import 'package:get/get.dart';

import '../controllers/assign_point_controller.dart';

class AssignPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignPointController>(
      () => AssignPointController(),
    );
  }
}
