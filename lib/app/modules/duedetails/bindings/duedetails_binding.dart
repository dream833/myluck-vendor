import 'package:get/get.dart';

import '../controllers/duedetails_controller.dart';

class DuedetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DuedetailsController>(
      () => DuedetailsController(),
    );
  }
}
