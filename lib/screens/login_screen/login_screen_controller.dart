part of 'login_screen_view.dart';

class LoginScreenController extends GetxController {
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  var authService = AuthService();
  var isLoading = false.obs;
  var box = GetStorage();
  RxBool rememberMe = false.obs;
  RxBool obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadRememberMe();
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value!;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void loadRememberMe() {
    bool saved = box.read('remember_me') ?? false;
    rememberMe.value = saved;
    if (saved) {
      emailCtrl.text = box.read('email') ?? '';
      passwordCtrl.text = box.read('password') ?? '';
    }
  }

  void login() async {
    try {
      isLoading.value = true;
      var response = await authService.loginService(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      if (response["result"] == true) {
        if (rememberMe.value) {
          box.write('remember_me', true);
          box.write('email', emailCtrl.text);
          box.write('password', passwordCtrl.text);
        } else {
          box.remove('remember_me');
          box.remove('email');
          box.remove('password');
        }

        box.write("token", response["data"]["token"]);
        Get.snackbar("Success", "Login success");
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.home);
        debugPrint("Token : ${response["data"]["token"]}");
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
