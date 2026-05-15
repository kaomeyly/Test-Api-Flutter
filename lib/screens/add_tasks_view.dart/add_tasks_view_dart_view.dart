import 'package:dio_todo_list/core/api/tasks_serevice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'add_tasks_view_dart_binding.dart';
part 'add_tasks_view_dart_controller.dart';

class AddTasksViewDartView extends GetView<AddTasksViewDartViewController> {
  const AddTasksViewDartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Add Task")));
  }
}
