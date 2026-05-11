import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiConfig {
  late Dio dio;

  String? token;

  void getToken() {
    var box = GetStorage();
    token = box.read("token");
  }

  ApiConfig() {
    getToken();
    dio = Dio(
      BaseOptions(
        baseUrl: "https://pheakdey.tchandalen.com",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    )..interceptors.add(PrettyDioLogger(requestBody: true));
  }
}
