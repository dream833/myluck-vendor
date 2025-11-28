import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class TermsconditionController extends GetxController {
  var isLoading = true.obs;
  var termsText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTerms();
  }

  Future<void> fetchTerms() async {
    try {
      isLoading.value = true;
      var response = await dioGet('terms-conditions');
      var data = response.data;

      if (data['status'] == 200) {
        termsText.value = data['data']['terms_condition'] ?? '';
      } else {
        Get.snackbar('Error', data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      debugPrint('Error fetching terms: $e');
      Get.snackbar('Error', 'Failed to load terms & conditions');
    } finally {
      isLoading.value = false;
    }
  }
}
