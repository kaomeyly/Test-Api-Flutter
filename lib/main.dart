import 'package:dio_todo_list/routes/app_pages.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    box.read("token");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppPages.getPages,
    );
  }
}
