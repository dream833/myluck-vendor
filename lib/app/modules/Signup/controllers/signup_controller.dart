
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  final fullname = TextEditingController();
  final email =TextEditingController();
  final phoneController = TextEditingController();
  final referralController = TextEditingController();
  var ispwvisible =true.obs;

  final selfPhoto = "".obs;
  final shopPhoto = "".obs;
  final docPhoto = "".obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickSelfPhoto() async {
    _pickImage((path) => selfPhoto.value = path);
  }

  Future<void> pickShopPhoto() async {
    _pickImage((path) => shopPhoto.value = path);
  }

  Future<void> pickDocPhoto() async {
    _pickImage((path) => docPhoto.value = path);
  }

  Future<void> _pickImage(Function(String) onPicked) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.teal),
              title: const Text("Take Photo"),
              onTap: () async {
                final XFile? file = await picker.pickImage(source: ImageSource.camera);
                if (file != null) {
                  onPicked(file.path);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.teal),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  onPicked(file.path);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void register() {
    if (selfPhoto.isEmpty ||
        shopPhoto.isEmpty ||
        docPhoto.isEmpty ||
        phoneController.text.isEmpty ||
        referralController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    // Dummy registration success
    Get.snackbar("Success", "Registration Completed",
        backgroundColor: Colors.teal, colorText: Colors.white);

    Get.offAllNamed('/home');
  }
}