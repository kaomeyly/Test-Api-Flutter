part of 'add_tasks_view.dart';

class AddTasksViewController extends GetxController {

   var taskSerive = TasksSerevice();
  var nameCtrl = TextEditingController();
  var desCtrl = TextEditingController();

  var isLoading = false.obs;

  void createTasks() async {
    if (nameCtrl.text.isNotEmpty && desCtrl.text.isNotEmpty) {
      isLoading.value = true;
      var response = await taskSerive.createTasks(
        name: nameCtrl.text,
        description: desCtrl.text,
      );
      isLoading.value = false;
      if (response["result"] == true) {
        Get.snackbar("Success", "Tasks Created");
        nameCtrl.clear();
        desCtrl.clear();
      }
    } else {
      Get.snackbar("Failed", "Tasks Failed");
    }
  }
}