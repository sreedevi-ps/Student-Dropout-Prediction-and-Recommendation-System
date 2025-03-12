import 'package:dio/dio.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/features/data_entry/data/model/student_entry_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StudentDataEntryRepo {
  static final dio = Dio();
  static EitherFuture<String> addStudent(
      {required StudentDataEntryModel student}) async {
    try {
      final response =
          await dio.post(ApiUrls.studentDataEntry, data: student.toJson());
      Map<String, dynamic> responseData = response.data;
      if (responseData['status'] == "success") {
        return right(
          response.data['message'],
        );
      } else {
        return left(response.data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  static EitherFuture<String> uploadFile() async {
    // Pick file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx'],
    );

    if (result != null) {
      try {
        String? filePath = result.files.single.path;
        String fileName = result.files.single.name;
        String extension = fileName.split('.').last.toLowerCase();

        // Validate file type
        if (extension != 'csv' && extension != 'xlsx') {
          return left('Invalid file type: $extension');
        }

        // Create Dio instance
        Dio dio = Dio();

        // Create form data
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            filePath!,
            // filename: fileName,
          ),
        });

        // Upload to API
        Response response = await dio.post(
          ApiUrls.bulkUpload,
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              // Add any additional headers (e.g., authorization) here
            },
          ),
        );
        Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == "success") {
          return right(
            response.data['message'],
          );
        } else {
          return left(response.data['message']);
        }
        // Handle response
        // if (response.statusCode == 200) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('File uploaded successfully!')),
        //   );
        // } else {
        //   throw Exception('Failed to upload file: ${response.statusCode}');
        // }
      } catch (e) {
        return left(e.toString());
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${e.toString()}')),
        // );
      }
    } else {
      return left('User canceled the file picker');
      // User canceled the file picker
    }
  }
}
