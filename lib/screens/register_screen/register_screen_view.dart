import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:dio_todo_list/widgets/txtfield/custom_txtfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'register_screen_binding.dart';
part 'register_screen_controller.dart';

class RegisterScreenView extends GetView<RegisterScreenViewController> {
  const RegisterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Column(
          children: [SizedBox(height: 30), Image.asset("assets/img/logo.png")],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 10),
            Text(
              "SING UP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "Turn Khmer documents, images, and PDFs into \neditable text instantly.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
            SizedBox(height: 70),
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
            Obx(
              () => customtextfield(
                hintText: "Enter Password",
                controller: controller.passwordCtrl,
                obscureText: controller.obscurePassword.value,
                icon: GestureDetector(
                  onTap: controller.togglePasswordVisibility,
                  child: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
           
            Obx(
              () => customtextfield(
                hintText: "Confirm password",
                controller:
                    controller.confirmPasswordCtrl, 
                obscureText: controller.obscureConfirmPassword.value,
                icon: GestureDetector(
                  onTap: controller.toggleConfirmPasswordVisibility,
                  child: Icon(
                    controller
                            .obscureConfirmPassword
                            .value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                controller.register();
              },
              child: Obx(
                () => Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset("assets/img/arrow_up.png"),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 30),

            Spacer(),

            Row(
              children: [
                Expanded(child: Divider(color: Colors.black, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or continue with",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),

                Expanded(child: Divider(color: Colors.black, thickness: 1)),
              ],
            ),

            SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.9),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset("assets/img/google.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5),
                      Text(
                        "Sign up",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By signing in, you accept our ",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(text: " and\n"),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(text: "."),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Row(
            //   mainAxisAlignment: .center,
            //   children: [
            //     Text("Don't have an account?"),
            //     SizedBox(width: 5),
            //     GestureDetector(
            //       onTap: () {
            //         Get.offAllNamed(AppRoutes.login);
            //       },
            //       child: Text(
            //         "Sign up",
            //         style: TextStyle(decoration: TextDecoration.underline),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
