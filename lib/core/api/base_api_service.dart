import 'package:dio/dio.dart';
import 'package:dio_todo_list/core/api/api_config.dart';
import 'package:flutter/widgets.dart';

class BaseApiService {
  final ApiConfig apiConfig = ApiConfig();

  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await ApiConfig().dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
    }
  }

  // ← បន្ថែម function នេះ
  Future<dynamic> postFormData({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      var response = await ApiConfig().dio.post(
        endpoint,
        data: data,
        options: Options(contentType: 'multipart/form-data'),
      );
      debugPrint(">>> UPLOAD AVATAR RESPONSE: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      debugPrint("postFormData error: ${e.message}");
      debugPrint("postFormData response: ${e.response?.data}");
      return {"result": false, "message": e.message};
    }
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await apiConfig.dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
    }
  }

  Future<dynamic> delete({required String endpoint}) async {
    try {
      var response = await apiConfig.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error ${e.toString()}");
    }
  }

  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      var response = await ApiConfig().dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
    }
  }
}
