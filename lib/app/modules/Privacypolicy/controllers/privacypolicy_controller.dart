import 'package:flutter/material.dart' show debugPrint;
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class PrivacypolicyController extends GetxController {
  var privacypolicy = ''.obs;
  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchprivacy();
  }

  Future<void> fetchprivacy() async {
    try {
      isloading.value = true;
      var response = await dioGet('privacy-policy');
      var data = response.data;

      if (data['status'] == 200) {
        privacypolicy.value = data['data']['privacy_policy'] ?? '';
      } else {
        Get.snackbar('Error', data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      debugPrint('Error fetching terms: $e');
      Get.snackbar('Error', 'Failed to load terms & conditions');
    } finally {
      isloading.value = false;
    }
  }
}
