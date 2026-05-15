part of 'add_tasks_view_dart_view.dart';

class AddTasksViewDartViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTasksViewDartViewController());
  }
}
