part of 'homescreen_view.dart';

class HomescreenViewController extends GetxController {
  var authService = AuthService();
  var box = GetStorage();

  late UserModel user;
  var tasks = [].obs;
  var completedTasksID = "".obs;
  var taskSerive = TasksSerevice();

  var isLoading = false.obs;
  var isdeleted = false.obs;
  var isLoadingTask = false.obs;
  var isCompleted = false.obs;

  var doneList = [].obs;
  var boradList = [].obs;

  int get boardCount => boradList.length;
  int get doneCount => doneList.length;

  void getProfile() async {
    isLoading.value = true;
    var response = await authService.fetchProfile();
    isLoading.value = false;
    
    if (response["data"] == null) return;
    user = UserModel.fromMap(response["data"]);
  }

  void getTasks({bool silent = false}) async {
    if (!silent) isLoadingTask.value = true;
    var response = await taskSerive.fetchTasks();
    if (!silent) isLoadingTask.value = false;

    if (response["result"] == false) {
      debugPrint("getTasks failed: ${response["message"]}");
      return;
    }

    tasks.value = response["data"] ?? [];
    if (tasks.isNotEmpty) {
      debugPrint("=== TASK DATA ===");
      debugPrint("All keys: ${tasks[0].keys.toList()}");
      debugPrint("Priority value: ${tasks[0]["priority"]}");
      debugPrint("Full task: ${tasks[0]}");
    }

    boradList.value = tasks
        .where((task) => task["completed"] == false)
        .toList();
    doneList.value = tasks.where((task) => task["completed"] == true).toList();
  }

  void deleteTask({required String id, required int index}) async {
    isdeleted.value = true;
    try {
      var response = await taskSerive.deleteTask(id: id);
      if (response["result"] == true) {
        Get.snackbar("Success", "Delete successful");
        isdeleted.value = false;
        getTasks(silent: true);
      }
    } catch (e) {
      debugPrint("Task Delete error : ${e.toString()}");
      isdeleted.value = false;
    }
  }

  void onDeleteTask({required String id, required int index}) {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure to delete?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text("No"),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                Get.back();
                deleteTask(id: id, index: index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: isdeleted.value
                  ? CircularProgressIndicator()
                  : Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    box.remove("token");
    Get.offAllNamed(AppRoutes.login);
  }

  String formatDateTime(String date) {
    var formatString = DateTime.parse(date);
    var formatedDate = DateFormat("dd MMM yyyy").format(formatString);
    return formatedDate;
  }

  void markCompleteTask({required String id, required int index}) async {
    try {
      isCompleted.value = true;
      completedTasksID.value = id;
      var response = await taskSerive.markComplete(id: id);
      if (response["result"] == true) {
        isCompleted.value = false;
        Get.snackbar("Success", "Task is Complete");
        getTasks(silent: true);
      }
    } catch (e) {
      isCompleted.value = false;
      Get.snackbar("Failed", "Task failed");
      debugPrint("Error ${e.toString()}");
    }
  }

  void unmarkCompleteTask({required String id, required int index}) async {
    try {
      isCompleted.value = true;
      completedTasksID.value = id;
      var response = await taskSerive.unmarkComplete(id: id);
      if (response["result"] == true) {
        isCompleted.value = false;
        Get.snackbar("Success", "Task moved back to Board");
        getTasks(silent: true);
      }
    } catch (e) {
      isCompleted.value = false;
      Get.snackbar("Failed", "Could not undo task");
      debugPrint("Error ${e.toString()}");
    }
  }

  void toggleMarkComplete({required String id}) {
    int freshIndex = tasks.indexWhere((element) => element["id"] == id);
    if (freshIndex == -1) return;

    if (tasks[freshIndex]["completed"]) {
      unmarkCompleteTask(id: id, index: freshIndex);
    } else {
      markCompleteTask(id: id, index: freshIndex);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getTasks();
  }
}
