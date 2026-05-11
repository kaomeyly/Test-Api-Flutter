part of 'login_screen_view.dart';

class LoginScreenController extends GetxController {
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  var authService = AuthService();
  var isLoading = false.obs;
  var box = GetStorage();

  void login() async {
    try {
      isLoading.value = true;
      var response = await authService.loginService(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      if (response["result"] == true) {
        Get.snackbar("Success", "Login success");
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.home);
        debugPrint("Token : ${response["data"]["token"]}");
        box.write("token", response["data"]["token"]);
      } else {
        Get.snackbar("Failed", "Login Failed");
        isLoading.value = false;
      }
    } catch (error) {
      Get.snackbar("Failed", "Login Failed");
      isLoading.value = false;
    }
  }
}
