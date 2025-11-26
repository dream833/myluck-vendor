import 'package:get/get.dart';

import '../controllers/own_purchase_history_controller.dart';

class OwnPurchaseHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnPurchaseHistoryController>(
      () => OwnPurchaseHistoryController(),
    );
  }
}
