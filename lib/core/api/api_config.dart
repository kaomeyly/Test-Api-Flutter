import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiConfig {
  late Dio dio;

  ApiConfig() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://pheakdey.tchandalen.com",
        headers: {"Content-Type": "application/json"},
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    )..interceptors.add(PrettyDioLogger(requestBody: true));
  }
}
