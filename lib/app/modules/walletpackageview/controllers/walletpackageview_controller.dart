import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class WalletpackageviewController extends GetxController {
  var isLoading = true.obs;
  var packages = [].obs;

  late Razorpay _razorpay;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();

    _razorpay = Razorpay();

    // Event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> fetchPackages() async {
    try {
      isLoading(true);
      final response = await dioGet("shopkeeper/rechage-package");

      if (response.statusCode == 200 && response.data["data"] != null) {
        packages.value = response.data["data"];
        print("✅ Loaded ${packages.length} packages");
      } else {
        Get.snackbar(
          "Error",
          "No packages found",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch packages: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  void startPayment(Map<String, dynamic> pkg) {
    try {
      var options = {
        'key': 'rzp_test_RMaLkyQSPvuyqO',
        'amount': (pkg["price"] * 100),
        'name': 'Reward Vendor',
        'description': '${pkg["package_title"]} Package',
        'prefill': {'contact': '9999999999', 'email': 'test@example.com'},
        'theme': {'color': '#008080'},
      };

      print(
        "🟢 Starting Razorpay for ${pkg["package_title"]} @ ₹${pkg["price"]}",
      );
      _razorpay.open(options);
    } catch (e) {
      print("❌ Razorpay init failed: $e");
      Get.snackbar(
        "Error",
        "Failed to start payment: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  /// ✅ Payment success handler
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("✅ Payment Success: ${response.paymentId}");

    Get.snackbar(
      "Success",
      "Payment Successful! Updating wallet...",
      backgroundColor: Colors.teal,
      colorText: Colors.white,
    );

    // Call API to update wallet balance
    await updateWallet(response.paymentId);
  }

  /// ❌ Payment failed handler
  void _handlePaymentError(PaymentFailureResponse response) {
    print("❌ Payment Failed: ${response.message}");
    Get.snackbar(
      "Payment Failed",
      "Error: ${response.message}",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  /// ⚡ Handle external wallets like Paytm
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("💡 External Wallet Selected: ${response.walletName}");
  }

  /// 🔹 Update wallet balance after success
  Future<void> updateWallet(String? paymentId) async {
    try {
      final userId = getBox.read('USER_ID');
      if (userId == null) {
        print("❌ No USER_ID found in storage!");
        return;
      }

      // Example payload, modify if your backend expects differently
      final response = await dioPost(
        endUrl: 'shopkeeper/add-wallet-balance',
        data: {"shopkeeper_id": userId, "payment_id": paymentId},
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Wallet Updated",
          "Your wallet has been credited successfully.",
          backgroundColor: Colors.teal,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Wallet update failed",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Wallet update error: $e");
      Get.snackbar(
        "Error",
        "Failed to update wallet: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    _razorpay.clear();
  }
}
