import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:dio_todo_list/core/api/tasks_serevice.dart';
import 'package:dio_todo_list/models/user_model.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

part 'homescreen_binding.dart';
part 'homescreen_controller.dart';

class HomescreenView extends GetView<HomescreenViewController> {
  const HomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.toNamed(AppRoutes.addTask)!.then((value) {
            controller.getTasks();
          });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? _buildProfilePlaceholder()
                      : _buildProfileHeader(),
                ),
                SizedBox(height: 20),
                Obx(
                  () => controller.isLoadingTask.value
                      ? _buildTaskPlaceholder()
                      : _buildTaskList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskPlaceholder() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: Container(height: 50, width: 100, color: Colors.grey),
        );
      },

      itemCount: 3,
    );
  }

  Widget _buildTaskList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _taskCard(index: index);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: controller.tasks.length,
    );
  }

  Widget _taskCard({required int index}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        // color: Color(0xFFD9D9D9).withValues(alpha: .5),
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Hight Priority",
                  style: GoogleFonts.spaceGrotesk(fontWeight: .bold),
                ),
              ),
              Spacer(),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade500,
                ),
                child: Icon(Icons.more_horiz, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            controller.tasks[index]["name"].toUpperCase(),
            style: GoogleFonts.spaceGrotesk(fontSize: 25, fontWeight: .bold),
          ),
          Text(
            controller.tasks[index]["description"],
            style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: .normal),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                // DateFormat(
                //   'dd MMMM yyyy',
                // ).format(DateTime.parse(controller.tasks[index]["created_at"])),
                "Date : ${controller.formatDateTime(controller.tasks[index]["created_at"])}",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: .normal,
                ),
              ),
              Spacer(),
              Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Mark as Done",
                  style: GoogleFonts.spaceGrotesk(fontWeight: .bold),
                ),
              ),
            ],
          ),
        ],
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
