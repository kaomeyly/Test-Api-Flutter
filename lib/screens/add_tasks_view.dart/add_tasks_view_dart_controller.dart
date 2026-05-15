part of 'add_tasks_view_dart_view.dart';

class AddTasksViewDartViewController extends GetxController {
  var taskSerive = TasksSerevice();

  void createTasks() async {
    var response = await taskSerive.createTasks(
      name: "Task 05",
      description: "Task 5",
    );
    if (response["result"] == true) {
      Get.snackbar("Success", "Tasks Created");
    }
  }
}
