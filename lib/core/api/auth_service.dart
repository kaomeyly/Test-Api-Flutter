import 'package:dio/dio.dart';
import 'package:dio_todo_list/core/api/base_api_service.dart';

class AuthService {
  final BaseApiService baseApi = BaseApiService();

  Future<Map<String, dynamic>> loginService({
    required String email,
    required String password,
  }) async {
    var response = await baseApi.post(
      endpoint: "/api/auth/login",
      data: {"email": email, "password": password},
    );
    return response;
  }

  Future<Map<String, dynamic>> registerService({
    required String name,
    required String email,
    required String password,
  }) async {
    var response = await baseApi.post(
      endpoint: "/api/auth/register",
      data: {"name": name, "email": email, "password": password},
    );
    return response;
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    var response = await baseApi.get(endpoint: "/api/profile/me");
    return response;
  }

  Future<Map<String, dynamic>> updateName({required String name}) async {
    var response = await baseApi.put(
      endpoint: "/api/profile/info",
      data: {"name": name},
    );
    return response;
  }

  Future<Map<String, dynamic>> updateEmail({required String email}) async {
    var response = await baseApi.put(
      endpoint: "/api/profile/change-email",
      data: {"email": email},
    );
    return response;
  }

  Future<Map<String, dynamic>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    var response = await baseApi.put(
      endpoint: "/api/profile/change-password",
      data: {"old_password": oldPassword, "new_password": newPassword},
    );
    return response;
  }

  Future<Map<String, dynamic>> updateAvatar({
    required String filePath,
  }) async {
    final formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(filePath),
    });
    var response = await baseApi.postFormData(
      endpoint: "/api/profile/avatar",
      data: formData,
    );
    return response;
  }
}