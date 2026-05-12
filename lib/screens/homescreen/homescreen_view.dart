import 'package:dio_todo_list/core/api/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'homescreen_binding.dart';
part 'homescreen_controller.dart';

class HomescreenView extends GetView<HomescreenViewController> {
  const HomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getProfile();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [_buildProfileHeader()]),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "https://static.vecteezy.com/system/resources/thumbnails/020/767/286/small/cute-girl-holding-smartphone-with-speech-bubble-heart-cartoon-character-hand-draw-art-illustration-vector.jpg",
          ),
        ),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "Kao Meyly",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            Text(
              "kaomeyly@gmail.com",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
