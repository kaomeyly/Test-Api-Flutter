import 'package:dio_todo_list/routes/app_routes.dart';
import 'package:dio_todo_list/screens/add_tasks/add_tasks_view.dart';
import 'package:dio_todo_list/screens/homescreen/homescreen_view.dart';
import 'package:dio_todo_list/screens/login_screen/login_screen_view.dart';
import 'package:dio_todo_list/screens/register_screen/register_screen_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreenView(),
      binding: LoginScreenViewBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreenView(),
      binding: RegisterScreenViewBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomescreenView(),
      binding: HomescreenViewBinding(),
    ),
    GetPage(
      name: AppRoutes.addTask,
      page: () => AddTasksView(),
      binding: AddTasksViewBinding(),
    ),
  ];
}
