import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class ContactusController extends GetxController {
  var isLoading = true.obs;

  var companyName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactUs();
  }

  Future<void> fetchContactUs() async {
    try {
      isLoading.value = true;

      var response = await dioGet('contact-us');
      var data = response.data;
      var meravalue = data['data'];
      if (data['status'] == 200) {
        companyName.value = meravalue['company_name'] ?? '';
        email.value = meravalue['email'] ?? '';
        phone.value = meravalue['phone'] ?? '';
        address.value = meravalue['address'] ?? '';
      } else {
        Get.snackbar('Error', data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      debugPrint('Error fetching contact details: $e');
      Get.snackbar('Error', 'Failed to load contact details');
    } finally {
      isLoading.value = false;
    }
  }
}
