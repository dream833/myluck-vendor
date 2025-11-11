import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class DuedetailsController extends GetxController {
  var dueList = [].obs;
  var isLoading = false.obs;
  late Razorpay razorpay;

  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    fetchDueList();
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }

  Future<void> fetchDueList() async {
    try {
      isLoading(true);
      final response = await dioPost(
        endUrl: "shopkeeper/due-payment",
        data: {"shop_id": 4},
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        dueList.assignAll(response.data["data"]);
      } else {
        dueList.clear();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load dues: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  /// 🔹 Pay Now via Razorpay
  void payNow(Map<String, dynamic> pkg) {
    var options = {
      'key': 'rzp_test_your_key_here',
      'amount': (pkg["price"] * 100).toInt(), // Razorpay amount in paisa
      'name': 'Reward Vendor',
      'description': pkg["package_title"],
      'prefill': {'contact': '9999999999', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Payment error: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar(
      "Payment Successful",
      "Payment ID: ${response.paymentId}",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Payment Failed",
      "Reason: ${response.message}",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", "Wallet Name: ${response.walletName}");
  }
}
  //TODO: Implement DuedetailsController

