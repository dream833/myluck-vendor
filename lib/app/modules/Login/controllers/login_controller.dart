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
    final context = Get.key.currentContext!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: bgColor));
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

      var data = response.data;

      if (data['status'] == 200) {
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

        showSnack(data['message'] ?? "Login Successful", bgColor: Colors.green);

        await Future.delayed(const Duration(milliseconds: 200));

        Get.offAllNamed('/bottom-navigation-bar');
      } else {
        showSnack(data['message'] ?? "Invalid credentials");
      }
    } catch (e) {
      showSnack("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
