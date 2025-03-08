import pandas as pd
import joblib


class Prediction:
    def __init__(self):
        self.model = joblib.load('xgb_b16_model.joblib')

        self.qualification_encoding = {
            "Secondary Education - 12th Year of Schooling or Eq.": 1,
            "Higher Education - Bachelor's Degree": 2,
            "Higher Education - Degree": 3,
            "Higher Education - Master's": 4,
            "Higher Education - Doctorate": 5,
            "Frequency of Higher Education": 6,
            "12th Year of Schooling - Not Completed": 9,
            "11th Year of Schooling - Not Completed": 10,
            "7th Year (Old)": 11,
            "Other - 11th Year of Schooling": 12,
            "10th Year of Schooling": 14,
            "General commerce course": 18,
            "Basic Education 3rd Cycle (9th/10th/11th Year) or Equiv.": 19,
            "Technical-professional course": 22,
            "7th year of schooling": 26,
            "2nd cycle of the general high school course": 27,
            "9th Year of Schooling - Not Completed": 29,
            "8th year of schooling": 30,
            "Unknown": 34,
            "Can't read or write": 35,
            "Can read without having a 4th year of schooling": 36,
            "Basic education 1st cycle (4th/5th year) or equiv.": 37,
            "Basic Education 2nd Cycle (6th/7th/8th Year) or Equiv.": 38,
            "Technological specialization course": 39,
            "Higher education - degree (1st cycle)": 40,
            "Specialized higher studies course": 41,
            "Professional higher technical course": 42,
            "Higher Education - Master (2nd cycle)": 43,
            "Higher Education - Doctorate (3rd cycle)": 44
        }

        self.occupation_encoding = {
            0: "Student",
            1: "Representatives of the Legislative Power and Executive Bodies, Directors, Directors and Executive Managers",
            2: "Specialists in Intellectual and Scientific Activities",
            3: "Intermediate Level Technicians and Professions",
            4: "Administrative staff",
            5: "Personal Services, Security and Safety Workers and Sellers",
            6: "Farmers and Skilled Workers in Agriculture, Fisheries and Forestry",
            7: "Skilled Workers in Industry, Construction and Craftsmen",
            8: "Installation and Machine Operators and Assembly Workers",
            9: "Unskilled Workers",
            10: "Armed Forces Professions",
            90: "Other Situation",
            99: "(blank)",
            122: "Health professionals",
            123: "Teachers",
            125: "Specialists in Information and Communication Technologies (ICT)",
            131: "Intermediate Level Science and Engineering Technicians and Professions",
            132: "Technicians and Professionals, of Intermediate Level of Health",
            134: "Intermediate Level Technicians from Legal, Social, Sports, Cultural and Similar Services",
            141: "Office Workers, Secretaries in General and Data Processing Operators",
            143: "Data, Accounting, Statistical, Financial Services and Registry-Related Operators",
            144: "Other Administrative Support Staff",
            151: "Personal Service Workers",
            152: "Sellers",
            153: "Personal Care Workers and the Like",
            171: "Skilled Construction Workers and the Like, Except Electricians",
            173: "Skilled Workers in Printing, Precision Instrument Manufacturing, Jewelers, Artisans and the Like",
            175: "Workers in Food Processing, Woodworking, Clothing and Other Industries and Crafts",
            191: "Cleaning Workers",
            192: "Unskilled Workers in Agriculture, Animal Production, Fisheries and Forestry",
            193: "Unskilled Workers in Extractive Industry, Construction, Manufacturing and Transport",
            194: "Meal Preparation Assistants"
        }

        self.course_encoding = {
            33: "Biofuel Production Technologies",
            171: "Animation and Multimedia Design",
            8014: "Social Service (evening attendance)",
            9003: "Agronomy",
            9070: "Communication Design",
            9085: "Veterinary Nursing",
            9119: "Informatics Engineering",
            9130: "Equinculture",
            9147: "Management",
            9238: "Social Service",
            9254: "Tourism",
            9500: "Nursing",
            9556: "Oral Hygiene",
            9670: "Advertising and Marketing Management",
            9773: "Journalism and Communication",
            9853: "Basic Education",
            9991: "Management (evening attendance)"
        }


    def encode_student_data(self, student_data):
        """ Convert student data dictionary into a list of numerical values """
        mother_qualification = self.qualification_encoding.get(
            student_data["mother_qualification"].strip(), 34) 
        father_qualification = self.qualification_encoding.get(
            student_data["father_qualification"].strip(), 34)
        mother_occupation = self.occupation_encoding.get(
            student_data["mother_occupation"].strip(), 9) 
        father_occupation = self.occupation_encoding.get(
            student_data["father_occupation"].strip(), 9)

        course = student_data["course"]

        debtor = int(student_data["debtor"])
        tuition_fees_up_to_date = int(student_data["tuition_fees_up_to_date"])
        scholarship_holder = int(student_data["scholarship_holder"])

        gender = 1 if student_data["gender"].strip().lower() == "male" else 0

        numerical_data = [
            student_data["application_mode"],
            student_data["application_order"],
            course,
            mother_qualification,
            father_qualification,
            mother_occupation,
            father_occupation,
            debtor,
            tuition_fees_up_to_date,
            gender,
            scholarship_holder,
            student_data["age"],
            student_data["gdp"],
            student_data["avg_enrolled"],
            student_data["avg_approved"],
            student_data["avg_grade"]
        ]

        return numerical_data

    def predict_student(self, student_data):
        """ Predict student outcome (dropout or graduate) """

        encoded_student_data = self.encode_student_data(student_data)

        final_features = [
            'Application_mode', 'Application_order', 'Course', 'Mother_qualification',
            'Father_qualification', 'Mother_occupation', 'Father_occupation', 'Debtor',
            'Tuition_fees_up_to_date', 'Gender', 'Scholarship_holder', 'Age', 'GDP',
            'avg_enrolled', 'avg_approved', 'avg_grade'
        ]

        student_df = pd.DataFrame(
            [encoded_student_data], columns=final_features)

        y_pred = self.model.predict(student_df)[0]
        y_prob = self.model.predict_proba(student_df)

        decoded_classes = ["graduate", "dropout"]
        prediction_result = decoded_classes[y_pred]

        print("Predicted class:", prediction_result)
        print("Prediction probabilities:", y_prob)

        return prediction_result
