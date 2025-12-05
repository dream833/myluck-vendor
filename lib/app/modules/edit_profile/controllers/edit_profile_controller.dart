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
    fetchProfile(noSnackbar: false);
  }

  Future<void> fetchProfile({required bool noSnackbar}) async {
    try {
      isLoading(true);

      var shopkeeperId = getBox.read(USER_ID);

      if (shopkeeperId == null) {
        print("❌ USER_ID not found in storage!");
        if (!noSnackbar) {
          _showSnack("Error", "No USER_ID found — please login again.");
        }
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

        name(data["name"] ?? "");
        shopName(data["shop_name"] ?? "");
        email(data["email"] ?? "");
        phone(data["mobile_no"] ?? "");
        address(data["address"] ?? "");
        selfPhoto(data["self_photo"] ?? "");
        shopPhoto(data["shop_photo"] ?? "");

        print("✅ Profile loaded successfully: ${name.value}");
      } else {
        print("⚠️ Invalid response: ${response.data}");
        if (!noSnackbar) {
          _showSnack("Error", "Failed to load profile data");
        }
      }
    } catch (e) {
      print("❌ Exception: $e");
      if (!noSnackbar) {
        _showSnack("Error", "Something went wrong: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  /// Overlay-safe snackbar
  void _showSnack(String title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      ),
    );
  }
}
