import 'package:get/get.dart';

import '../controllers/inviteus_controller.dart';

class InviteusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteusController>(
      () => InviteusController(),
    );
  }
}
