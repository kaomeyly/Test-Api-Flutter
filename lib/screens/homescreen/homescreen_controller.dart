part of 'homescreen_view.dart';

class HomescreenViewController extends GetxController {
  var authService = AuthService();
  var box = GetStorage();

  late UserModel user;
  var tasks = [].obs;
  var taskSerive = TasksSerevice();

  var isLoading = false.obs;

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

  void deleteTask({required String id}) async {
    var response = await taskSerive.deleteTask(id: id);

    if (response["result"] == true) {
      Get.snackbar("Success", "Delete successful");
    }
    
  }

  void logout() {
    box.remove("token");
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getTasks();
  }
}
