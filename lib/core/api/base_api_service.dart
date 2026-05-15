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
      return response;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
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
      return response;
    } on DioException catch (e) {
      debugPrint("Error ${e.toString()}");
    }
  }

  Future<dynamic> put({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await ApiConfig().dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      debugPrint("Error : ${e.message}");
    }
  }
}
