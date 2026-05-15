import 'package:dio_todo_list/core/api/tasks_serevice.dart';
import 'package:dio_todo_list/widgets/txtfield/custom_txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'add_tasks_binding.dart';
part 'add_tasks_controller.dart';

class AddTasksView extends GetView<AddTasksViewController> {
  const AddTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            customtextfield(
              hintText: "Enter task name",
              controller: controller.nameCtrl,
            ),
            SizedBox(height: 10),
            customtextfield(
              hintText: "Enter task description",
              controller: controller.desCtrl,
              isMultiline: true,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                controller.createTasks();
              },
              child: Container(
                height: 50,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: .circular(15),
                ),
                child: Center(
                  child: Obx(
                    () => controller.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
                            "Add Task",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
