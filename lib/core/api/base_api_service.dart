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
}
