part of 'add_tasks_view.dart';

class AddTasksViewController extends GetxController {
  var taskSerive = TasksSerevice();
  var nameCtrl = TextEditingController();
  var desCtrl = TextEditingController();

  var isLoading = false.obs;

  var args = Get.arguments;

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

  void updateTask() async {
    if (nameCtrl.text.isNotEmpty && desCtrl.text.isNotEmpty) {
      try {
        isLoading.value = true;
        var response = await taskSerive.updateTask(
          id: args["id"],
          name: nameCtrl.text,
          description: desCtrl.text,
        );

        if (response["result"] == true) {
          Get.snackbar("Success", "Tasks Update");
          isLoading.value = false;
          // nameCtrl.clear();
          // desCtrl.clear();
        } else {
          Get.snackbar("Failed", "Tasks Failed");
        }
      } catch (e) {
        Get.snackbar("Failed", "Tasks Failed");
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    if (args != null) {
      nameCtrl.text = args["name"];
      desCtrl.text = args["description"];
    }
  }
}
