import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:dio_todo_list/core/api/tasks_serevice.dart';
import 'package:dio_todo_list/models/user_model.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

part 'homescreen_binding.dart';
part 'homescreen_controller.dart';

class HomescreenView extends GetView<HomescreenViewController> {
  const HomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.getProfile();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? _buildProfilePlaceholder()
                    : _buildProfileHeader(),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.logout();
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(controller.user.avatar),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              controller.user.name,
              style: TextStyle(fontSize: 20, fontWeight: .bold, height: 1.2),
            ),

            Text(
              controller.user.email,
              style: TextStyle(fontSize: 13, fontWeight: .normal, height: 1.2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfilePlaceholder() {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          child: CircleAvatar(radius: 25),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade100,
              child: Container(width: 100, height: 20, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade100,
              child: Container(width: 150, height: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
