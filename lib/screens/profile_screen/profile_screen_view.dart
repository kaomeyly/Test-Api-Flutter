import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_screen_binding.dart';
part 'profile_screen_controller.dart';

class ProfileScreenView extends GetView<ProfileScreenViewController> {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F4F0),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black12),
            ),
            child: const Icon(Icons.arrow_back, size: 18, color: Colors.black),
          ),
        ),
        title: Text(
          "Setting",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Obx(
                () => GestureDetector(
                  onTap: controller.pickAvatar,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.avatarUrl.value.isNotEmpty
                            ? NetworkImage(controller.avatarUrl.value)
                            : null,
                        backgroundColor: Colors.grey.shade300,
                        child: controller.avatarUrl.value.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Center(
                child: Text(
                  controller.nameDisplay.value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Obx(
              () => Center(
                child: Text(
                  controller.emailDisplay.value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            _sectionLabel("PERSONAL INFORMATION"),
            const SizedBox(height: 8),
            _settingItem(
              icon: Icons.person_outline,
              title: "Change Name",
              subtitle: "Change your full name",
              onTap: () => _showChangeNameDialog(),
            ),
            _settingItem(
              icon: Icons.email_outlined,
              title: "Change Email",
              subtitle: "Change your email address",
              onTap: () => _showChangeEmailDialog(),
            ),
            _settingItem(
              icon: Icons.lock_outline,
              title: "Change Password",
              subtitle: "Change your password",
              onTap: () => _showChangePasswordDialog(),
            ),
            const SizedBox(height: 24),

            // LOGOUT
            _sectionLabel("ACCOUNT"),
            const SizedBox(height: 8),
            _settingItem(
              icon: Icons.logout,
              title: "Logout",
              subtitle: "Sign out of your account",
              iconColor: Colors.red,
              titleColor: Colors.red,
              onTap: () => _showLogoutDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _settingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color titleColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeNameDialog() {
    final ctrl = TextEditingController(text: controller.nameDisplay.value);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Change Name",
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: "Enter new name",
            hintStyle: GoogleFonts.spaceGrotesk(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.spaceGrotesk()),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.updateName(ctrl.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text("Save", style: GoogleFonts.spaceGrotesk()),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeEmailDialog() {
    final ctrl = TextEditingController(text: controller.emailDisplay.value);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Change Email",
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter new email",
            hintStyle: GoogleFonts.spaceGrotesk(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.spaceGrotesk()),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.updateEmail(ctrl.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text("Save", style: GoogleFonts.spaceGrotesk()),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Change Password",
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldCtrl,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Old password",
                hintStyle: GoogleFonts.spaceGrotesk(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "New password",
                hintStyle: GoogleFonts.spaceGrotesk(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.spaceGrotesk()),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.updatePassword(oldCtrl.text, newCtrl.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text("Save", style: GoogleFonts.spaceGrotesk()),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Logout",
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: GoogleFonts.spaceGrotesk(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Cancel", style: GoogleFonts.spaceGrotesk()),
          ),
          ElevatedButton(
            onPressed: controller.logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Logout", style: GoogleFonts.spaceGrotesk()),
          ),
        ],
      ),
    );
  }
}
