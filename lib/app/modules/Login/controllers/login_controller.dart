import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';
import 'package:rewardvendor/app/modules/edit_profile/controllers/edit_profile_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController(text: 'vendor1800@gmail.com');
  final passwordController = TextEditingController(text: '12345');

  var isLoading = false.obs;

  // 🔹 Coins, Stars, Total Balance
  var coins = 0.obs;
  var stars = 0.obs;
  var totalBalance = 0.obs;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await dioPost(
        endUrl: 'shopkeeper/login',
        data: {"email": email, "password": password},
      );

      var data = response.data;

      if (data['status'] == 200) {
        final token = data['access_token'];
        final user = data['data'];

        // 🔹 Save user info in GetStorage
        getBox.write(USER_TOKEN, token);
        getBox.write(IS_USER_LOGGED_IN, true);
        getBox.write(USER_ID, user['id']);
        getBox.write(USER_EMAIL, user['email']);

        getBox.write(USER_LOGIN, true);

        // 🔹 Save coins and stars from API if available
        coins.value = user['coin'] ?? 0;
        stars.value = user['star'] ?? 0;
        totalBalance.value = coins.value + stars.value;

        print("✅ USER_ID: ${user['id']}");
        print("✅ EMAIL: ${user['email']}");
        print("✅ TOKEN: $token");
        print("✅ Coins: ${coins.value}, Stars: ${stars.value}");
        await Get.find<EditProfileController>().fetchProfile();
        Get.snackbar(
          "Success",
          data['message'] ?? "Login Successful",
          backgroundColor: Colors.teal,
          colorText: Colors.white,
        );

        // 🔹 Navigate to Home / Bottom Navigation
        Get.offAllNamed('/bottom-navigation-bar');
      } else {
        Get.snackbar(
          "Failed",
          data['message'] ?? "Invalid credentials",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
