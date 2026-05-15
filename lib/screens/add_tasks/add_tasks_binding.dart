part of 'add_tasks_view.dart';

class AddTasksViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => AddTasksViewController());
   }
}