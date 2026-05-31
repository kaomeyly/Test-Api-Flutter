import 'package:dio_todo_list/core/api/base_api_service.dart';
import 'package:flutter/material.dart';

class TasksSerevice {
  final baseApiServie = BaseApiService();

  Future<Map<String, dynamic>> fetchTasks() async {
    var response = await baseApiServie.get(endpoint: "/api/tasks");
    return response;
  }

  Future<Map<String, dynamic>> createTasks({
    required String name,
    required String description,
    String? priority,
    DateTime? dueDate,
  }) async {
    try {
      final data = {
        "name": name,
        "description": description,
        "priority": priority,
        "due_date": dueDate?.toIso8601String(),
      };
      debugPrint(">>> CREATE REQUEST DATA: $data");
      var response = await baseApiServie.post(
        endpoint: "/api/tasks",
        data: data,
      );
      debugPrint(">>> CREATE RESPONSE: $response");
      return response;
    } catch (e) {
      debugPrint("createTasks error: $e");
      return {"result": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteTask({required String id}) async {
    var response = await baseApiServie.delete(endpoint: "/api/tasks/$id");
    return response;
  }

  Future<Map<String, dynamic>> updateTask({
    required String id,
    required String name,
    required String description,
    String? priority,
    DateTime? dueDate,
  }) async {
    try {
      final data = {
        "name": name,
        "description": description,
        "priority": priority,
        "due_date": dueDate?.toIso8601String(),
      };
      debugPrint(">>> UPDATE REQUEST DATA: $data");
      var response = await baseApiServie.put(
        endpoint: "/api/tasks/$id",
        data: data,
      );
      debugPrint(">>> UPDATE RESPONSE: $response");
      return response;
    } catch (e) {
      debugPrint("updateTask error: $e");
      return {"result": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchTaskById({required String id}) async {
    try {
      var response = await baseApiServie.get(endpoint: "/api/tasks/$id");
      debugPrint(">>> FETCH TASK BY ID: $response");
      return response;
    } catch (e) {
      debugPrint("fetchTaskById error: $e");
      return {"result": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> markComplete({required String id}) async {
    var response = await baseApiServie.put(
      endpoint: "/api/tasks/mark-completed/$id",
    );
    return response;
  }

  Future<Map<String, dynamic>> unmarkComplete({required String id}) async {
    var response = await baseApiServie.put(
      endpoint: "/api/tasks/unmark-completed/$id",
    );
    return response;
  }
}
