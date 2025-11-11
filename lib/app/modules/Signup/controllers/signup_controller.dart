import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rewardvendor/app/data/function/mydio.dart';

class SignupController extends GetxController {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final shopNameController = TextEditingController();
  final addressController = TextEditingController();
  final referralController = TextEditingController();

  var ispwvisible = true.obs;
  var isLoading = false.obs;

  final selfPhoto = "".obs;
  final shopPhoto = "".obs;
  final docPhoto = "".obs;

  final ImagePicker picker = ImagePicker();

  var lat = 0.0.obs;
  var lng = 0.0.obs;

  /// ✅ Category list and selection
  final categories = <Map<String, dynamic>>[].obs;
  final selectedCategory = RxnString();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final res = await dioGet("store-category-list");

      if (res.statusCode == 200 && res.data["data"] != null) {
        categories.value = List<Map<String, dynamic>>.from(
          (res.data["data"] as List).map(
            (e) => {
              "id": e["id"].toString(),
              "name": e["category_name"].toString(),
              "icon": e["icon"] ?? "",
            },
          ),
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to load categories",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong loading categories",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // ✅ Image picker functions
  Future<void> pickSelfPhoto() async => _pickImage((p) => selfPhoto.value = p);
  Future<void> pickShopPhoto() async => _pickImage((p) => shopPhoto.value = p);
  Future<void> pickDocPhoto() async => _pickImage((p) => docPhoto.value = p);

  Future<void> _pickImage(Function(String) onPicked) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.teal),
              title: const Text("Take Photo"),
              onTap: () async {
                final file = await picker.pickImage(source: ImageSource.camera);
                if (file != null) onPicked(file.path);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.teal),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                final file = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) onPicked(file.path);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Get current location
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      Get.snackbar("Error", "Please enable location services");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Location permission denied");
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat.value = pos.latitude;
    lng.value = pos.longitude;
    debugPrint("✅ Location: ${lat.value}, ${lng.value}");
  }

  Future<void> register() async {
    if (fullname.text.isEmpty ||
        email.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        shopNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        selfPhoto.value.isEmpty ||
        shopPhoto.value.isEmpty ||
        docPhoto.value.isEmpty ||
        referralController.text.isEmpty ||
        selectedCategory.value == null) {
      Get.snackbar(
        "Error",
        "Please fill all required fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    await getCurrentLocation();

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Colors.teal)),
        barrierDismissible: false,
      );

      var formData = {
        "name": fullname.text,
        "email": email.text,
        "password": passwordController.text,
        "mobile_no": phoneController.text,
        "shop_name": shopNameController.text,
        "address": addressController.text,
        "latitude": lat.value.toString(),
        "longitude": lng.value.toString(),
        "shop_category": selectedCategory.value,
        "referral_code": referralController.text,
        "registration_document": await dio.MultipartFile.fromFile(
          docPhoto.value,
          filename: "doc_${DateTime.now().millisecondsSinceEpoch}.jpg",
        ),
        "shop_photo": await dio.MultipartFile.fromFile(
          shopPhoto.value,
          filename: "shop_${DateTime.now().millisecondsSinceEpoch}.jpg",
        ),
        "self_photo": await dio.MultipartFile.fromFile(
          selfPhoto.value,
          filename: "self_${DateTime.now().millisecondsSinceEpoch}.jpg",
        ),
      };

      var response = await dioPost(
        endUrl: "shopkeeper/register",
        data: formData,
        isFile: true,
      );

      Get.back();

      if (response.statusCode == 200 &&
          (response.data["status"] == 200 ||
              response.data["success"] == true)) {
        Get.snackbar(
          "Success",
          "Registration completed successfully",
          backgroundColor: Colors.teal,
          colorText: Colors.white,
        );
        Get.offAllNamed('/bottom-navigation-bar');
      } else {
        Get.snackbar(
          "Failed",
          response.data["message"] ?? "Registration failed",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
