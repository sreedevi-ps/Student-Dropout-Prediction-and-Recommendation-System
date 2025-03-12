class ApiUrls {
  static const baseUrl = "https://h99pz5b5-5000.inc1.devtunnels.ms/";

  // static const baseUrl = "https://vlc3xq7d-5000.inc1.devtunnels.ms/";

  static const String loginApi = "${baseUrl}login";

  static const studentDataEntry = "${baseUrl}add_student";

  static const viewRecommendations = "${baseUrl}recommend";

  static const studentsList = "${baseUrl}get_students";
  static const studentProfile = "${baseUrl}get_student/";

  ///upload_students
  static const bulkUpload = "${baseUrl}upload_students";

  //predict
  static const predict = "${baseUrl}predict";

  ///admin-recommend
  static const adminRecommend = "${baseUrl}admin-recommend";
}
