import 'package:get/get.dart';

import '../controllers/termscondition_controller.dart';

class TermsconditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsconditionController>(
      () => TermsconditionController(),
    );
  }
}
