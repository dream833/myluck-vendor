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
  final description = TextEditingController();

  var ispwvisible = true.obs;
  var isLoading = false.obs;

  final selfPhoto = "".obs;
  final shopPhoto = "".obs;
  final docPhoto = "".obs;

  final ImagePicker picker = ImagePicker();

  var lat = 0.0.obs;
  var lng = 0.0.obs;

  /// Category list
  final categories = <Map<String, dynamic>>[].obs;
  final selectedCategory = RxnString();

  void showSnack(String msg, {Color bg = Colors.redAccent}) {
    final context = Get.key.currentContext!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: bg));
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    loadCategories();
  }

  // Load Categories
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
        showSnack("Failed to load categories");
      }
    } catch (e) {
      showSnack("Something went wrong loading categories");
    }
  }

  // Image pickers
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

  // Location
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnack("Please enable location services");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showSnack("Location permission denied");
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat.value = pos.latitude;
    lng.value = pos.longitude;
  }

  // Validation
  bool validateFields() {
    if (fullname.text.isEmpty ||
        email.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        shopNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        referralController.text.isEmpty ||
        selfPhoto.value.isEmpty ||
        shopPhoto.value.isEmpty ||
        docPhoto.value.isEmpty ||
        selectedCategory.value == null) {
      showSnack("All fields are mandatory");
      return false;
    }

    if (phoneController.text.length != 10 ||
        !RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text)) {
      showSnack("Mobile number must be 10 digits");
      return false;
    }

    return true;
  }

  // Register function
  Future<void> register() async {
    if (!validateFields()) return;

    await getCurrentLocation();

    // Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.teal)),
      barrierDismissible: false,
    );

    try {
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
        "description": description.text,
      };

      var response = await dioPost(
        endUrl: "shopkeeper/register",
        data: formData,
        isFile: true,
      );

      // Close loading only (DO NOT POP PAGE)
      Get.back();

      int status = response.statusCode ?? 0;
      var body = response.data;

      // SUCCESS
      if (status == 200 &&
          body["status"] == 200 &&
          body["message"] == "Registration Successfully.") {
        showSnack("Registration completed successfully", bg: Colors.teal);
        Get.offAllNamed('/login');
        return;
      }

      // VALIDATION ERROR 422
      if (status == 422) {
        String finalMsg = "";

        var msgObj = body["message"]; // map -> list -> msg

        if (msgObj is Map) {
          var firstEntry = msgObj.entries.first;
          var errorsList = firstEntry.value;

          if (errorsList is List && errorsList.isNotEmpty) {
            finalMsg = errorsList.first.toString();
          } else {
            finalMsg = "Validation error";
          }
        } else {
          finalMsg = msgObj.toString();
        }

        showSnack(finalMsg, bg: Colors.red);
        return;
      }

      showSnack(body["message"]?.toString() ?? "Registration failed");
    } catch (e) {
      // Close loading only
      Get.back();
      showSnack("Something went wrong: $e");
    }
  }
}
