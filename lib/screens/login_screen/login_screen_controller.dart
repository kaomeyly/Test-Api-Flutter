part of 'login_screen_view.dart';

class LoginScreenController extends GetxController {
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  var authService = AuthService();

  void login() async {
    try {
      var response = await authService.loginService(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
      if (response["result"] == true) {
        Get.snackbar("Success", "Login success");
      } else {
        Get.snackbar("Failed", "Login Failed");
      }
    } catch (e) {
      Get.snackbar("Failed", "Login Failed");
    }
  }
}
