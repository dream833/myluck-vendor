import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

  
    if (phone == "123" && password == "123") {
      Get.snackbar("Success", "Login Successful",
          backgroundColor: Colors.teal, colorText: Colors.white);
      Get.offAllNamed('/bottom-navigation-bar');
    } else {
      Get.snackbar("Failed", "Invalid credentials",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}