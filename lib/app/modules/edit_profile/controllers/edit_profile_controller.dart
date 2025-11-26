import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class EditProfileController extends GetxController {
  var isLoading = true.obs;

  final name = ''.obs;
  final shopName = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;
  final selfPhoto = ''.obs;
  final shopPhoto = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);

      var shopkeeperId = getBox.read(USER_ID);

      if (shopkeeperId == null) {
        print("❌ USER_ID not found in storage!");
        Get.snackbar(
          "Error",
          "No USER_ID found — please login again.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        isLoading(false);
        return;
      }

      int id = int.tryParse(shopkeeperId.toString()) ?? 0;

      print("🟢 Shopkeeper ID from box: $id");

      final response = await dioPost(
        endUrl: "shopkeeper/profile",
        data: {"shopkeeper_id": id},
      );

      print("🟢 Raw Response: ${response.data}");

      if (response.statusCode == 200 && response.data["data"] != null) {
        final data = response.data["data"];

        name.value = data["name"] ?? "";
        shopName.value = data["shop_name"] ?? "";
        email.value = data["email"] ?? "";
        phone.value = data["mobile_no"] ?? "";
        address.value = data["address"] ?? "";
        selfPhoto.value = data["self_photo"] ?? "";
        shopPhoto.value = data["shop_photo"] ?? "";

        print("✅ Profile loaded successfully: ${name.value}");
      } else {
        print("⚠️ Invalid response: ${response.data}");
        Get.snackbar(
          "Error",
          "Failed to load profile data",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
