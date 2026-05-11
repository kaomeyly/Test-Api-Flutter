part of 'homescreen_view.dart';

class HomescreenViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => HomescreenViewController());
   }
}