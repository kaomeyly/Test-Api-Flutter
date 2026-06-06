part of 'register_screen_view.dart';

class RegisterScreenViewController extends GetxController {
  var fnCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var confirmPasswordCtrl = TextEditingController();

  var authService = AuthService();
  var isLoading = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void register() async {
    try {
      isLoading.value = true;

      var response = await authService.registerService(
        name: fnCtrl.text,
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      if (response["result"] == true) {
        GetStorage().write("token", response["data"]["token"]);
        Get.snackbar("Success", "Register Successful");
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar("Failed", response["message"] ?? "Register Failed");
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar("Failed", "Register Failed");
      isLoading.value = false;
    }
  }
}
