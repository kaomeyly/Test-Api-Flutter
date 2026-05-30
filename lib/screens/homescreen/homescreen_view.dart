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
      backgroundColor: const Color(0xFFF5F4F0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4B3FA0),
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          Get.toNamed(AppRoutes.addTask)!.then((value) {
            controller.getTasks();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Obx(
                    () => controller.isLoading.value
                        ? _buildProfilePlaceholder()
                        : _buildProfileHeader(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: _buildGreeting(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: _buildStatsRow(),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Builder(
                    builder: (context) {
                      final tabController = DefaultTabController.of(context);
                      return AnimatedBuilder(
                        animation: tabController,
                        builder: (context, _) {
                          final selectedIndex = tabController.index;
                          return TabBar(
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
                                      _tabBadge(
                                        label: "${controller.boardCount}",
                                        active: selectedIndex == 0,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Tasks",
                                        style: GoogleFonts.spaceGrotesk(
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
                                      _tabBadge(
                                        label: "${controller.doneCount}",
                                        active: selectedIndex == 1,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Done",
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ContentSizeTabBarView(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    final String greeting = hour < 12
        ? "GOOD\nMORNING!"
        : hour < 17
        ? "GOOD\nAFTERNOON!"
        : "GOOD\nEVENING!";
    return Text(
      greeting,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 52,
        fontWeight: FontWeight.w700,
        height: 0.95,
        letterSpacing: -1,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _buildStatsRow() {
    final now = DateTime.now();
    final dayName = DateFormat('EEEE').format(now);
    final dateStr = DateFormat('MMM dd, yyyy').format(now);
    return Obx(() {
      final total = controller.tasks.length;
      final done = controller.doneList.length;
      final pct = total == 0 ? 0 : ((done / total) * 100).round();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's $dayName",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  dateStr,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: const Color(0xff282C20),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$pct% Done",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Completed Tasks",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: const Color(0xff282C20),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _tabBadge({required String label, required bool active}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.transparent,
        border: active
            ? null
            : Border.all(color: Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : Colors.grey.shade600,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTaskPlaceholder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskList({required List<dynamic> tasks}) {
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.checklist_rounded,
                size: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                "No tasks here",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Tap + to add a new task",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) => _swipableTaskCard(task: tasks[index]),
    );
  }

  Widget _swipableTaskCard({required dynamic task}) {
    return Dismissible(
      key: ValueKey(task["id"]),
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.4,
        DismissDirection.endToStart: 0.4,
      },
      confirmDismiss: (_) async {
        controller.toggleMarkComplete(id: task["id"]);
        return false;
      },
      background: _swipeBackground(
        color: const Color(0xFF1A1A1A),
        icon: Icons.check_rounded,
        alignment: Alignment.centerLeft,
        label: "Done",
        iconColor: Colors.white,
        labelColor: Colors.white,
      ),
      secondaryBackground: _swipeBackground(
        color: Colors.white,
        icon: Icons.undo_rounded,
        alignment: Alignment.centerRight,
        label: "Undo",
        iconColor: const Color(0xFF1A1A1A),
        labelColor: const Color(0xFF1A1A1A),
      ),
      child: _taskCard(task: task),
    );
  }

  Widget _swipeBackground({
    required Color color,
    required IconData icon,
    required Alignment alignment,
    required String label,
    required Color iconColor,
    required Color labelColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (alignment == Alignment.centerLeft) ...[
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                color: labelColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ] else ...[
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                color: labelColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, color: iconColor, size: 22),
          ],
        ],
      ),
    );
  }

  Widget _taskCard({required dynamic task}) {
    final String priority = task["priority"] ?? "High Priority";
    final Color dotColor = priority.toLowerCase().contains("high")
        ? const Color(0xFFE24B4A)
        : priority.toLowerCase().contains("medium")
        ? const Color(0xFFEF9F27)
        : const Color(0xFF639922);

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFC8C2B8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      priority,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      int index = controller.tasks.indexWhere(
                        (t) => t["id"] == task["id"],
                      );
                      controller.onDeleteTask(id: task["id"], index: index);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          "Delete",
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.addTask,
                        arguments: task,
                      )!.then((value) => controller.getTasks());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.edit_outlined, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          "Update",
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black26,
                  ),
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            task["name"].toString().toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              height: 1.1,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            task["description"] ?? "",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              color: const Color(0xFF555555),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                "Date : ${controller.formatDateTime(task["created_at"])}",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.toggleMarkComplete(id: task["id"]),
                child: Obx(() {
                  final isInBoard = controller.boradList.any(
                    (t) => t["id"] == task["id"],
                  );
                  final isLoading =
                      controller.isCompleted.value &&
                      controller.completedTasksID.value == task["id"];
                  return Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: isInBoard ? Colors.white : const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: isLoading
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isInBoard ? Colors.black : Colors.white,
                            ),
                          )
                        : Text(
                            isInBoard ? "Mark as Done" : "Done ✓",
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: isInBoard
                                  ? const Color(0xFF1A1A1A)
                                  : Colors.white,
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
          radius: 22,
          backgroundImage: NetworkImage(controller.user.avatar),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.user.name.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              controller.user.email,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                color: const Color(0xff282C20),
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.settings_outlined, size: 18),
            color: const Color(0xFF1B1919),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePlaceholder() {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: const CircleAvatar(radius: 22, backgroundColor: Colors.grey),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 100,
                height: 14,
                color: Colors.grey,
                margin: const EdgeInsets.only(bottom: 6),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(width: 150, height: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
