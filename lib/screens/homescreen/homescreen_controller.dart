part of 'homescreen_view.dart';

class HomescreenViewController extends GetxController {
  var authService = AuthService();
  void getProfile() async {
    var response = await authService.fetchProfile();

    debugPrint(response.toString());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }
}
