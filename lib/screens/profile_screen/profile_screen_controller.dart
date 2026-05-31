part of 'profile_screen_view.dart';

class ProfileScreenViewController extends GetxController {
  var authService = AuthService();
  var box = GetStorage();

  var isLoading = false.obs;
  var nameDisplay = ''.obs;
  var emailDisplay = ''.obs;
  var avatarUrl = ''.obs;

  void getProfile() async {
    var response = await authService.fetchProfile();
    if (response["result"] == true) {
      nameDisplay.value = response["data"]["name"] ?? '';
      emailDisplay.value = response["data"]["email"] ?? '';
      avatarUrl.value = response["data"]["avatar"] ?? '';
    }
  }

  void updateName(String name) async {
  if (name.isEmpty) return;
  isLoading.value = true;
  var response = await authService.updateName(name: name);
  isLoading.value = false;
  debugPrint(">>> UPDATE NAME RESPONSE: $response"); // ← បន្ថែម
  if (response["result"] == true) {
    nameDisplay.value = name;
    Get.back();
    Get.snackbar("Success", "Name updated");
  } else {
    Get.snackbar("Failed", "Could not update name");
  }
}

  void updateEmail(String email) async {
    if (email.isEmpty) return;
    isLoading.value = true;
    var response = await authService.updateEmail(email: email);
    isLoading.value = false;
    if (response["result"] == true) {
      emailDisplay.value = email;
      Get.back();
      Get.snackbar("Success", "Email updated");
    } else {
      Get.snackbar("Failed", "Could not update email");
    }
  }

  void updatePassword(String oldPassword, String newPassword) async {
    if (oldPassword.isEmpty || newPassword.isEmpty) return;
    isLoading.value = true;
    var response = await authService.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    isLoading.value = false;
    if (response["result"] == true) {
      Get.back();
      Get.snackbar("Success", "Password updated");
    } else {
      Get.snackbar("Failed", "Could not update password");
    }
  }

  void pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    isLoading.value = true;
    var response = await authService.updateAvatar(filePath: picked.path);
    isLoading.value = false;
    if (response["result"] == true) {
      avatarUrl.value = response["data"]["avatar"] ?? avatarUrl.value;
      Get.snackbar("Success", "Avatar updated");
    } else {
      Get.snackbar("Failed", "Could not update avatar");
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
  }
}
