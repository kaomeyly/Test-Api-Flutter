import 'package:dio_todo_list/core/api/base_api_service.dart';

class TasksSerevice {
  final baseApiServie = BaseApiService();

  Future<Map<String, dynamic>> fetchTasks() async {
    var response = await baseApiServie.get(endpoint: "/api/tasks");

    return response;
  }

  Future<Map<String, dynamic>> createTasks({
    required String name,
    required String description,
  }) async {
    var response = await baseApiServie.post(
      endpoint: "/api/tasks",
      data: {"name": name, "description": description},
    );

    return response;
  }

  Future<Map<String, dynamic>> deleteTask({required String id}) async {
    var response = await baseApiServie.delete(endpoint: "/api/tasks/$id");

    return response;
  }
}
