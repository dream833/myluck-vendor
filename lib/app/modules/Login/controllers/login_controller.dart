import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';
import 'package:rewardvendor/app/modules/edit_profile/controllers/edit_profile_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController(text: 'vendor1800@gmail.com');
  final passwordController = TextEditingController(text: '12345');

  var isLoading = false.obs;
  var coins = 0.obs;
  var stars = 0.obs;
  var totalBalance = 0.obs;

  void showSnack(String msg, {Color bgColor = Colors.redAccent}) {
    final context = Get.context ?? Get.overlayContext;

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: bgColor,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Get.rawSnackbar(
        message: msg,
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnack("Please fill all fields");
      return;
    }

    try {
      isLoading.value = true;
      final response = await dioPost(
        endUrl: 'shopkeeper/login',
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 401) {
        showSnack("Invalid credentials");
        return;
      }
      var data = response.data;
      if (data['status'] == 200 && data['message'] == "Invalid credentials.") {
        showSnack("Invalid credentials");
        return;
      }
      if (data['status'] == 200 && data['data'] != null && data['data'] != []) {
        final token = data['access_token'];
        final user = data['data'];
        getBox.write(USER_TOKEN, token);
        getBox.write(IS_USER_LOGGED_IN, true);
        getBox.write(USER_ID, user['id']);
        getBox.write(USER_EMAIL, user['email']);
        getBox.write(USER_LOGIN, true);
        getBox.write(REFERRAL_CODE, user['self_referral_code']);

        coins.value = user['coin'] ?? 0;
        stars.value = user['star'] ?? 0;
        totalBalance.value = coins.value + stars.value;

        await Get.find<EditProfileController>().fetchProfile(noSnackbar: true);

        showSnack("Login Successful", bgColor: Colors.green);

        Future.delayed(const Duration(milliseconds: 200), () {
          Get.offAllNamed('/bottom-navigation-bar');
        });
        return;
      }
      showSnack(data['message'] ?? "Login failed");
    } catch (e) {
      showSnack("Something went wrong");
      log("ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
