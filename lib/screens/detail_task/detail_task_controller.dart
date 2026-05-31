part of 'detail_task_view.dart';

class DetailTaskViewController extends GetxController {
  var taskService = TasksSerevice();
  var task = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;
  var args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (args != null) {
      task.value = Map<String, dynamic>.from(args);
    }
  }

  void loadTask() {
    if (args != null) {
      task.value = Map<String, dynamic>.from(args);
    }
  }

  String formatDate(dynamic date) {
    if (date == null) return '-';
    try {
      final parsed = DateTime.parse(date.toString());
      return DateFormat('dd - MMM - yyyy').format(parsed);
    } catch (_) {
      return '-';
    }
  }

  void toggleComplete() async {
    if (task.value == null) return;
    isLoading.value = true;
    try {
      final id = task.value!["id"];
      final isCompleted = task.value!["completed"] == true;
      dynamic response;
      if (isCompleted) {
        response = await taskService.unmarkComplete(id: id);
      } else {
        response = await taskService.markComplete(id: id);
      }
      if (response["result"] == true) {
        task.update((val) {
          val!["completed"] = !isCompleted;
        });
        Get.snackbar(
          "Success",
          isCompleted ? "Task moved back to Board" : "Task is Complete",
        );
      }
    } catch (e) {
      Get.snackbar("Failed", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTask() {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure to delete?"),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              isLoading.value = true;
              try {
                final response = await taskService.deleteTask(
                  id: task.value!["id"],
                );
                if (response["result"] == true) {
                  Get.back();
                  Get.snackbar("Success", "Task deleted");
                }
              } catch (e) {
                Get.snackbar("Failed", "Could not delete task");
              } finally {
                isLoading.value = false;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
