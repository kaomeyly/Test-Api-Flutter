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

  Future <Map<String, dynamic>>fetchProfile() async{
    var response = await baseApi.get(endpoint: "/api/profile/me");
    return response;
  } 
}
