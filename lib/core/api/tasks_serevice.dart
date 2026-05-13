import 'package:dio_todo_list/core/api/base_api_service.dart';

class TasksSerevice {
  final baseApiServie = BaseApiService();

  Future<Map<String, dynamic>> fetchTasks() async {
    var response = await baseApiServie.get(endpoint: "/api/tasks");

    return response;
  }
}
