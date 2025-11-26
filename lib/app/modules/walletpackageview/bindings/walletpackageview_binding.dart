import 'package:get/get.dart';

import '../controllers/walletpackageview_controller.dart';

class WalletpackageviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletpackageviewController>(
      () => WalletpackageviewController(),
    );
  }
}
