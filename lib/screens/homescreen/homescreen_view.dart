import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
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
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
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
                  TabBar(
                    indicatorColor: Colors.black,
                    indicatorWeight: 2,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Obx(
                        () => Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${controller.boardCount}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Tasks",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${controller.doneCount}",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ContentSizeTabBarView(
                    children: [
                      Obx(
                        () => controller.isLoadingTask.value
                            ? _buildTaskPlaceholder()
                            : _buildTaskList(tasks: controller.boradList),
                      ),
                      Obx(
                        () => controller.isLoadingTask.value
                            ? _buildTaskPlaceholder()
                            : _buildTaskList(tasks: controller.doneList),
                      ),
                    ],
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

  Widget _buildTaskList({required List<dynamic> tasks}) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _taskCard(task: tasks[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: tasks.length,
    );
  }

  Widget _taskCard({required dynamic task}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  "High Priority",
                  style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        int index = controller.tasks.indexWhere(
                          (t) => t["id"] == task["id"],
                        );
                        controller.onDeleteTask(id: task["id"], index: index);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 5),
                          Text("Delete", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.addTask, arguments: task)!.then((
                          value,
                        ) {
                          controller.getTasks();
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.green),
                          SizedBox(width: 5),
                          Text("Update", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                  ];
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade500,
                  ),
                  child: Icon(Icons.more_horiz, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            task["name"].toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            task["description"],
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Date : ${controller.formatDateTime(task["created_at"])}",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  controller.toggleMarkComplete(id: task["id"]);
                },
                child: Obx(() {
                  final isInBoard = controller.boradList.any(
                    (t) => t["id"] == task["id"],
                  );

                  return Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                        controller.isCompleted.value &&
                            controller.completedTasksID.value == task["id"]
                        ? CircularProgressIndicator()
                        : Text(
                            isInBoard ? "Mark as Done" : "Done",
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.user.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            Text(
              controller.user.email,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                height: 1.2,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: const Color.fromARGB(255, 27, 25, 25),
          ),
          onPressed: () {},
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
