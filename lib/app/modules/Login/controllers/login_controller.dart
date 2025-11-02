import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController(text: 'sura120@gmail.com');
  final passwordController = TextEditingController(text: '123456');

  var isLoading = false.obs;

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

        getBox.write(USER_TOKEN, token);
        getBox.write(USER_ID, data['data']['id']);
        getBox.write(USER_EMAIL, data['data']['email']);
        getBox.write(USER_LOGIN, true);

        Get.snackbar(
          "Success",
          data['message'] ?? "Login Successful",
          backgroundColor: Colors.teal,
          colorText: Colors.white,
        );

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
        "Something went wrong",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
