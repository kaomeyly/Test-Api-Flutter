import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:dio_todo_list/widgets/txtfield/custom_txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

part 'login_screen_binding.dart';
part 'login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customtextfield(
              hintText: "Enter Email",
              controller: controller.emailCtrl,
            ),
            SizedBox(height: 20),
            customtextfield(
              hintText: "Enter Password",
              controller: controller.passwordCtrl,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                controller.login();
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(
                  () => Center(
                    child: controller.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.register);
              },
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  Text(
                    "Sign up!!",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
