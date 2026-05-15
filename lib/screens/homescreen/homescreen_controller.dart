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

  void getTasks() async {
    var response = await taskSerive.fetchTasks();

    tasks.value = response["data"];

    debugPrint(response.toString());
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
