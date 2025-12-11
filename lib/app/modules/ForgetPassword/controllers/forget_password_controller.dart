import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/function/mydio.dart';

class ForgetpasswordController extends GetxController {
  final emailController = TextEditingController();
  final emailError = ''.obs;
  final isLoading = false.obs;

  void showSnack(String msg, {Color bg = Colors.redAccent}) {
    final context = Get.key.currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showTopSnack(String msg) {
    final context = Get.key.currentContext!;

    ScaffoldMessenger.of(context).clearMaterialBanners();

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.white,
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.teal,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const Icon(Icons.info, color: Colors.teal),
        actions: const [SizedBox.shrink()],
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).clearMaterialBanners();
    });
  }

  void sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = "Email field can’t be empty";
      showTopSnack("Email field can’t be empty");
      return;
    }

    emailError.value = "";
    isLoading.value = true;

    try {
      final response = await dioPost(
        endUrl: 'customer/forgot-password',
        data: {"email": email},
      );

      final data = response.data;
      final message = data['message'];

      if (response.statusCode == 200) {
        showTopSnack(data['message'] ?? "Reset link sent successfully");
        emailController.clear();
      } else {
        showTopSnack("Failed: $message");
      }
    } catch (e) {
      print("❌ Error: $e");
      showTopSnack("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
