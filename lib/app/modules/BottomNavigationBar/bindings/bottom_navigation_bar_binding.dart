import 'package:get/get.dart';
import 'package:rewardvendor/app/modules/BottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';



class BottomnavigationbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavigationbarController>(
      () => BottomnavigationbarController(),
    );
  }
}
