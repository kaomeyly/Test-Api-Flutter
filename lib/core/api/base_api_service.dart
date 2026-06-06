import 'package:dio/dio.dart';
import 'package:dio_todo_list/core/api/api_config.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';

class BaseApiService {
  final Dio dio = ApiConfig().dio;

  void _handle403() {
    GetStorage().remove("token");
    Get.offAllNamed(AppRoutes.login);
  }

  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
      if (e.response?.statusCode == 403) _handle403();
      return {"result": false, "message": e.message};
    }
  }

  Future<dynamic> postFormData({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      var response = await dio.post(
        endpoint,
        data: data,
        options: Options(contentType: 'multipart/form-data'),
      );
      return response.data;
    } on DioException catch (e) {
      debugPrint("postFormData error: ${e.message}");
      if (e.response?.statusCode == 403) _handle403();
      return {"result": false, "message": e.message};
    }
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
      if (e.response?.statusCode == 403) _handle403();
      return {"result": false, "message": e.message};
    }
  }

  Future<dynamic> delete({required String endpoint}) async {
    try {
      var response = await dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error ${e.toString()}");
      if (e.response?.statusCode == 403) _handle403();
      return {"result": false, "message": e.message};
    }
  }

  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      var response = await dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
      if (e.response?.statusCode == 403) _handle403();
      return {"result": false, "message": e.message};
    }
  }
}
