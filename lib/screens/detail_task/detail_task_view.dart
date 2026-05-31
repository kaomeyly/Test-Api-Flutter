import 'package:dio_todo_list/core/api/tasks_serevice.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

part 'detail_task_binding.dart';
part 'detail_task_controller.dart';

class DetailTaskView extends GetView<DetailTaskViewController> {
  const DetailTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F4F0),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Task Detail",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => controller.deleteTask(),
              child: const Icon(Icons.delete_outline, color: Colors.black54),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final task = controller.task.value;
        if (task == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final bool isCompleted = task["completed"] == true;
        final String priority = task["priority"] ?? "High Priority";
        final Color priorityColor = priority.toLowerCase().contains("high")
            ? const Color(0xFFE24B4A)
            : priority.toLowerCase().contains("medium")
            ? const Color(0xFFEF9F27)
            : const Color(0xFF639922);

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  priority,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                task["name"].toString().toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                  letterSpacing: -0.5,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                task["description"] ?? "",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFFEF9F27)
                          : const Color(0xFF639922),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isCompleted ? "Task is completed" : "Task in progress",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isCompleted
                          ? const Color(0xFFEF9F27)
                          : const Color(0xFF639922),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _divider(),
              const SizedBox(height: 16),
              _dateRow(
                label: "Start Date",
                value: controller.formatDate(task["created_at"]),
              ),
              const SizedBox(height: 12),
              _dateRow(
                label: "Due Date",
                value: controller.formatDate(task["due_date"]),
              ),
              const SizedBox(height: 12),
              _divider(),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.addTask,
                          arguments: task,
                        )!.then((_) => controller.loadTask());
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: Colors.black12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Task",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.toggleComplete(),
                      child: Obx(
                        () => Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          alignment: Alignment.center,
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  isCompleted ? "Undone" : "Mark as Done",
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade300, thickness: 1);
  }

  Widget _dateRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
