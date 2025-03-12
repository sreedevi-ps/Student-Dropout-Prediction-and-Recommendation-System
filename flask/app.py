from flask import Flask, request, redirect, url_for, session, jsonify, send_from_directory
from flask_cors import CORS
from dotenv import load_dotenv
import os
from models import db, StudentData
from predict import Prediction
from recommendation import get_recommendations
import pandas as pd
from flask_migrate import Migrate
from werkzeug.utils import secure_filename
from sqlalchemy.exc import IntegrityError
predictor = Prediction()

load_dotenv()

app = Flask(__name__)
CORS(app)

app.secret_key = os.getenv('SECRET_KEY', 'your_secret_key')

ADMIN_USERNAME = os.getenv("ADMIN_USERNAME")
ADMIN_PASSWORD = os.getenv("ADMIN_PASSWORD")

BASE_URL = os.getenv("BASE_URL")

UPLOAD_FOLDER = 'uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URL")
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

ADMINS_LIST = os.getenv("ADMINS", "").split(",")

ADMINS = {
    course.strip(): {
        "username": course.strip(),
        "password": course.strip().split()[0].lower() + "123"
    }
    for course in ADMINS_LIST
}

db.init_app(app)
migrate = Migrate(app, db)

with app.app_context():
    db.create_all()


@app.route('/')
def home():
    text = "Hello! welcome to Student dropout api!"
    return jsonify(text)


@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    for course_name, credentials in ADMINS.items():
        if username == credentials["username"] and password == credentials["password"]:
            session['user'] = username
            return jsonify({
                "status": "success",
                "response_code": 200,
                "message": f"Admin login successful for {course_name}!",
                "user": username,
                "id": "admin"
            })

    student = StudentData.query.filter_by(name=username).first()

    if student and student.student_id == password:
        session['user'] = username
        return jsonify({
            "status": "success",
            "response_code": 200,
            "message": "Student login successful!",
            "user": "student",
            "id": student.student_id
        })

    return jsonify({
        "status": "failure",
        "response_code": 401,
        "message": "Invalid credentials!"
    })


@app.route('/logout', methods=['POST'])
def logout():
    if 'user' in session:
        session.pop('user')
        return jsonify({
            "status": "success",
            "response_code": 200,
            "message": "Logged out successfully!"
        })
    else:
        return jsonify({
            "status": "failure",
            "response_code": 400,
            "message": "No active session found!"
        })


@app.route('/add_student', methods=['POST'])
def add_student():
    try:
        data = request.json

        required_fields = ["student_id", "name"]
        for field in required_fields:
            if field not in data:
                return jsonify({"status": "failure", "message": f"Missing required field: {field}"}), 400

        new_student = StudentData(
            student_id=data.get('student_id'),
            name=data.get('name'),
            application_mode=1,
            application_order=5,
            course=data.get('course'),
            mother_qualification=data.get('mother_qualification'),
            father_qualification=data.get('father_qualification'),
            mother_occupation=data.get('mother_occupation'),
            father_occupation=data.get('father_occupation'),
            debtor=data.get('debtor', False),
            tuition_fees_up_to_date=data.get('tuition_fees_up_to_date', False),
            gender=data.get('gender'),
            scholarship_holder=data.get('scholarship_holder', False),
            age=data.get('age'),
            gdp=data.get('gdp'),
            avg_enrolled=data.get('avg_enrolled'),
            avg_approved=data.get('avg_approved'),
            avg_grade=data.get('avg_grade')
        )

        db.session.add(new_student)
        db.session.commit()

        return jsonify({
            "status": "success",
            "message": "Student added successfully!",
            "user": "student",
            "student_id": new_student.student_id
        }), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({"status": "failure", "message": str(e)}), 500


@app.route('/upload_students', methods=['POST'])
def upload_students():
    try:
        if 'file' not in request.files:
            return jsonify({"status": "failure", "message": "No file part"}), 400

        file = request.files['file']
        if file.filename == '':
            return jsonify({"status": "failure", "message": "No selected file"}), 400

        filename = secure_filename(file.filename)
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        file.save(filepath)

        if filename.endswith('.csv'):
            df = pd.read_csv(filepath)
        elif filename.endswith('.xlsx'):
            df = pd.read_excel(filepath)
        else:
            return jsonify({"status": "failure", "message": "Invalid file format. Only CSV or Excel files are allowed."}), 400

        required_columns = {"student_id", "name"}
        if not required_columns.issubset(df.columns):
            return jsonify({"status": "failure", "message": "Missing required columns: student_id, name"}), 400

        students = []
        for _, row in df.iterrows():
            student = StudentData(
                student_id=row.get('student_id'),
                name=row.get('name'),
                application_mode=1,
                application_order=5,
                course=row.get('course'),
                mother_qualification=row.get('mother_qualification'),
                father_qualification=row.get('father_qualification'),
                mother_occupation=row.get('mother_occupation'),
                father_occupation=row.get('father_occupation'),
                debtor=row.get('debtor', False),
                tuition_fees_up_to_date=row.get(
                    'tuition_fees_up_to_date', False),
                gender=row.get('gender'),
                scholarship_holder=row.get('scholarship_holder', False),
                age=row.get('age'),
                gdp=row.get('gdp'),
                avg_enrolled=row.get('avg_enrolled'),
                avg_approved=row.get('avg_approved'),
                avg_grade=row.get('avg_grade')
            )
            students.append(student)

        db.session.bulk_save_objects(students)
        db.session.commit()

        return jsonify({"status": "success", "message": "Students uploaded successfully!", "count": len(students)}), 201

    except IntegrityError as e:
        db.session.rollback()
        return jsonify({"status": "error", "message": "Duplicate student_id detected. Please check the file and try again."}), 400

    except Exception as e:
        db.session.rollback()
        return jsonify({"status": "error", "message": str(e)}), 500


@app.route('/get_student/<student_id>', methods=['GET'])
def get_student(student_id):
    try:
        student = StudentData.query.filter_by(student_id=student_id).first()

        if not student:
            return jsonify({"status": "failure", "message": "Student not found"}), 404

        student_data = {
            "student_id": student.student_id,
            "name": student.name,
            "application_mode": student.application_mode,
            "application_order": student.application_order,
            "course": student.course,
            "mother_qualification": student.mother_qualification,
            "father_qualification": student.father_qualification,
            "mother_occupation": student.mother_occupation,
            "father_occupation": student.father_occupation,
            "debtor": student.debtor,
            "tuition_fees_up_to_date": student.tuition_fees_up_to_date,
            "gender": student.gender,
            "scholarship_holder": student.scholarship_holder,
            "age": student.age,
            "gdp": student.gdp,
            "avg_enrolled": student.avg_enrolled,
            "avg_approved": student.avg_approved,
            "avg_grade": student.avg_grade,
            "photo_url": f"{BASE_URL}/uploads/{os.path.basename(student.photo)}" if student.photo else None,
            "recommendation": student.recommendation
        }

        return jsonify({"status": "success", "data": student_data}), 200

    except Exception as e:
        return jsonify({"status": "failure", "message": str(e)}), 500


@app.route('/get_students', methods=['POST'])
def get_students():
    try:
        data = request.get_json()
        course = data.get("course")

        if not course:
            return jsonify({"status": "failure", "message": "Course is required"}), 400

        students = StudentData.query.with_entities(
            StudentData.student_id, StudentData.name
        ).filter_by(course=course).all()

        student_list = [{"student_id": s.student_id, "name": s.name}
                        for s in students]

        return jsonify({"status": "success", "students": student_list}), 200
    except Exception as e:
        return jsonify({"status": "failure", "message": str(e)}), 500


@app.route('/predict', methods=['POST'])
def predict():
    try:
        student_data = request.get_json()
        student_id = student_data.get("student_id")

        if not student_id:
            return jsonify({'error': 'No student ID provided'}), 400

        student = StudentData.query.filter_by(student_id=student_id).first()
        if not student:
            return jsonify({'error': 'Student not found'}), 404

        student_data_from_db = {
            "application_mode": student.application_mode,
            "application_order": student.application_order,
            "course": student.course,
            "mother_qualification": student.mother_qualification,
            "father_qualification": student.father_qualification,
            "mother_occupation": student.mother_occupation,
            "father_occupation": student.father_occupation,
            "debtor": student.debtor,
            "tuition_fees_up_to_date": student.tuition_fees_up_to_date,
            "gender": student.gender,
            "scholarship_holder": student.scholarship_holder,
            "age": student.age,
            "gdp": student.gdp,
            "avg_enrolled": student.avg_enrolled,
            "avg_approved": student.avg_approved,
            "avg_grade": student.avg_grade
        }

        for key, value in student_data_from_db.items():
            if value is None:
                student_data_from_db[key] = 0

        predictor = Prediction()
        prediction_result = predictor.predict_student(student_data_from_db)
        student.prediction = prediction_result
        db.session.commit()

        return jsonify({
            'student_id': student_id,
            'prediction': prediction_result,
            'status': 'success'
        })

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route("/recommend", methods=["POST"])
def recommend():
    """API endpoint for recommendations"""
    data = request.get_json()
    user_query = data.get("query")

    if not user_query:
        return jsonify({"error": "Query is required"}), 400

    response = get_recommendations(user_query)
    return jsonify(response)


@app.route("/admin-recommend", methods=["POST"])
def admin_recommend():
    """API endpoint for recommendations"""
    data = request.get_json()
    user_query = data.get("query")
    student_id = data.get("student_id")

    if not user_query:
        return jsonify({"error": "query is required"}), 400
    if not student_id:
        return jsonify({"error": "student_id is required"}), 400

    response = get_recommendations(user_query)
    recommendations = response.get("recommendations")

    if recommendations:
        student = StudentData.query.filter_by(student_id=student_id).first()
        if student:
            student.recommendation = recommendations
        db.session.commit()
        return jsonify({"message": "Recommendations updated successfully", "recommendations": recommendations, "status": "success"})

    return jsonify({"error": "No recommendations generated"}), 400


@app.route('/upload_photo', methods=['POST'])
def upload_photo():
    try:
        if 'student_id' not in request.form:
            return jsonify({"status": "failure", "message": "Student ID is required"}), 400

        student_id = request.form['student_id']
        if 'photo' not in request.files:
            return jsonify({"status": "failure", "message": "No photo part"}), 400

        file = request.files['photo']
        if file.filename == '':
            return jsonify({"status": "failure", "message": "No selected file"}), 400

        filename = secure_filename(f"{student_id}.jpg")
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        file.save(filepath)

        student = StudentData.query.filter_by(student_id=student_id).first()
        if not student:
            return jsonify({"status": "failure", "message": "Student not found"}), 404

        student.photo = filepath
        db.session.commit()

        photo_url = f"{BASE_URL}/uploads/{filename}"

        return jsonify({"status": "success", "message": "Photo uploaded successfully", "photo_url": photo_url}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"status": "failure", "message": str(e)}), 500


@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)


if __name__ == '__main__':
    app.run(debug=True, port=5500)
