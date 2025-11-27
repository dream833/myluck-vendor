import 'package:get/get.dart';

import '../controllers/commissionwallet_controller.dart';

class CommissionwalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommissionwalletController>(
      () => CommissionwalletController(),
    );
  }
}
