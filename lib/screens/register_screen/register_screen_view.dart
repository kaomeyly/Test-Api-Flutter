import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:dio_todo_list/widgets/txtfield/custom_txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'register_screen_binding.dart';
part 'register_screen_controller.dart';

class RegisterScreenView extends GetView<RegisterScreenViewController> {
  const RegisterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customtextfield(
              hintText: "Enter Full Name",
              controller: controller.fnCtrl,
            ),
            SizedBox(height: 20),
            customtextfield(
              hintText: "Enter Email",
              controller: controller.emailCtrl,
            ),
            SizedBox(height: 20),
            customtextfield(
              hintText: "Enter Password",
              controller: controller.passwordCtrl,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                controller.register();
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
                            "Register",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: .center,
              children: [
                Text("Don't have an account?"),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
