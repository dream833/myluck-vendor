import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';

class HomeController extends GetxController {
  var creditBalance = 0.obs;
  var unpaidCredits = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDuePayments();
  }

  /// 🔹 Fetch Due Payments
  Future<void> fetchDuePayments() async {
    try {
      isLoading(true);

      final shopId = getBox.read('USER_ID');
      print("📡 Fetching dues for shop_id: $shopId");

      final response = await dioPost(
        endUrl: "shopkeeper/due-payment",
        data: {"shop_id": 4},
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        final List data = response.data["data"];

        final dueList = data
            .where((e) => e["payment_status"] == "due")
            .toList();
        unpaidCredits.value = dueList.length;

        double totalDue = 0;
        for (var item in dueList) {
          totalDue += double.tryParse(item["price"].toString()) ?? 0;
        }

        creditBalance.value = totalDue.toInt();

        print("✅ Found ${dueList.length} due payments | ₹$totalDue total due");
      } else {
        unpaidCredits.value = 0;
        creditBalance.value = 0;
        print("⚠️ No due payments found");
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch due payments: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCreditData() async {
    await fetchDuePayments();
  }

  void checkRewardEligibility() {
    final cs = Get.theme.colorScheme;

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
