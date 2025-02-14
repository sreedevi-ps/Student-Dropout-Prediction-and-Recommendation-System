from flask import Flask, request, redirect, url_for, session, jsonify
from flask_cors import CORS 
from dotenv import load_dotenv
import os
from models import db, StudentData 

load_dotenv()

app = Flask(__name__)
CORS(app)

app.secret_key = os.getenv('SECRET_KEY', 'your_secret_key')

ADMIN_USERNAME = os.getenv('ADMIN_USERNAME', 'admin')
ADMIN_PASSWORD = os.getenv('ADMIN_PASSWORD', 'admin')

app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL', 'postgresql://afthab:password@localhost:5432/Student')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

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

    if username == ADMIN_USERNAME and password == ADMIN_PASSWORD:
        session['user'] = username
        return jsonify({
            "status": "success",
            "response_code": 200,
            "message": "Admin login successful!",
            "user": username,
            "id": username
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
            "user":"student",
            "student_id": new_student.student_id
        }), 201

    except Exception as e:
        db.session.rollback()  
        return jsonify({"status": "failure", "message": str(e)}), 500


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
            "avg_grade": student.avg_grade
        }

        return jsonify({"status": "success", "data": student_data}), 200

    except Exception as e:
        return jsonify({"status": "failure", "message": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True,port=5500)
