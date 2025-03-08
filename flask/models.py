from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class StudentData(db.Model):
    __tablename__ = 'student_data'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    student_id = db.Column(db.String, unique=True, nullable=False)
    name = db.Column(db.String, nullable=False)
    application_mode = db.Column(db.Integer, nullable=True)
    application_order = db.Column(db.Integer, nullable=True)
    course = db.Column(db.String, nullable=True)
    mother_qualification = db.Column(db.String, nullable=True)
    father_qualification = db.Column(db.String, nullable=True)
    mother_occupation = db.Column(db.String, nullable=True)
    father_occupation = db.Column(db.String, nullable=True)
    debtor = db.Column(db.Boolean, nullable=True)
    tuition_fees_up_to_date = db.Column(db.Boolean, nullable=True)
    gender = db.Column(db.String, nullable=True)
    scholarship_holder = db.Column(db.Boolean, nullable=True)
    age = db.Column(db.Integer, nullable=True)
    gdp = db.Column(db.Float, nullable=True)
    avg_enrolled = db.Column(db.Float, nullable=True)
    avg_approved = db.Column(db.Float, nullable=True)
    avg_grade = db.Column(db.Float, nullable=True)
    prediction = db.Column(db.String, nullable=True)
    photo = db.Column(db.String, nullable=True)
