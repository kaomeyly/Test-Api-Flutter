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
      appBar: AppBar(
        title: Text(controller.args != null ? "Update Task" : "Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ADD TASKS",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Turn Khmer documents, images, and PDFs into editable text instantly.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 30),
            Text(
              "Title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            customtextfield(
              controller: controller.nameCtrl,
              hintText: "Enter task name",
              focusNode: controller.nameFocus,
            ),
            SizedBox(height: 15),
            Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            customtextfield(
              hintText: "Enter task description",
              controller: controller.desCtrl,
              isMultiline: true,
            ),
            SizedBox(height: 10),
            Text(
              "Priority",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            customtextfield(
              hintText: "Select task priority",
              controller: controller.desCtrl,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                FocusScope.of(Get.context!).unfocus();
                controller.args != null
                    ? controller.updateTask()
                    : controller.createTasks();
              },
              child: Container(
                height: 50,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: .circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Row(
                        children: [
                          Obx(
                            () => controller.isLoading.value
                                ? CircularProgressIndicator()
                                : Text(
                                    controller.args != null
                                        ? "Update Task"
                                        : "ADD TASKS",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                          Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/img/arrow_up.png"),
                          ),
                        ],
                      ),
                    ],
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
