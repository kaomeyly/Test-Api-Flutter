import 'package:dio_todo_list/routes/app_pages.dart';
import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:dio_todo_list/screens/spash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var box = GetStorage();
  String? token;

  void getToken() {
    setState(() {
      token = box.read("token");
    });

    debugPrint("token : $token");
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? AppRoutes.home : AppRoutes.login,
      // home: SpashScreen(),
      getPages: AppPages.getPages,
    );
  }
}
