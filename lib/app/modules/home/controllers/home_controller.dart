import 'package:get/get.dart';


class HomeController extends GetxController {
  var firstTimeStatus = "First purchase credits must be cleared before assigning new points."
      .obs;
  var creditBalance = 120.obs;
  var unpaidCredits = 50.obs;

  void checkRewardEligibility() {
    final cs = Get.theme.colorScheme; // Material 3 color scheme

    if (unpaidCredits.value > 0) {
      Get.snackbar(
        "Not Eligible",
        "Clear unpaid credits to get rewards",
        backgroundColor: cs.error,
        colorText: cs.onError,
      );
    } else {
      Get.snackbar(
        "Eligible!",
        "You are eligible for this month’s reward",
        backgroundColor: cs.primary,
        colorText: cs.onPrimary,
      );
    }
  }
}
