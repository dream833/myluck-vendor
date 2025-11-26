import 'package:get/get.dart';

import '../controllers/walletbalance_controller.dart';

class WalletbalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletbalanceController>(
      () => WalletbalanceController(),
    );
  }
}
