import 'package:get/get.dart';

import '../controllers/qrscannerpage_controller.dart';

class QrscannerpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrscannerController>(() => QrscannerController());
  }
}
