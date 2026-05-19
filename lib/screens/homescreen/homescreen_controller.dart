part of 'homescreen_view.dart';

class HomescreenViewController extends GetxController {
  var authService = AuthService();
  var box = GetStorage();

  late UserModel user;
  var tasks = [].obs;
  var taskSerive = TasksSerevice();

  var isLoading = false.obs;
  var isdeleted = false.obs;

  void getProfile() async {
    isLoading.value = true;

    var response = await authService.fetchProfile();

    isLoading.value = false;

    user = UserModel.fromMap(response["data"]);

    debugPrint(response.toString());
  }

  var isLoadingTask = false.obs;

  void getTasks() async {
    isLoading.value = true;
    var response = await taskSerive.fetchTasks();
    isLoading.value = false;
    tasks.value = response["data"];

    debugPrint(response.toString());
  }

  void deleteTask({required String id, required int index}) async {
    isdeleted.value = true;
    try {
      var response = await taskSerive.deleteTask(id: id);

      debugPrint("Response $response");

      if (response["result"] == true) {
        // tasks.removeWhere((task) => task["id"] == id);
        Get.snackbar("Success", "Delete successful");
        isdeleted.value = false;
        tasks.removeAt(index);
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

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getTasks();
  }
}
