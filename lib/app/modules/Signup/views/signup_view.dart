import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/signup_controller.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imagePicker(
              label: "Upload Self Photo",
              imagePath: controller.selfPhoto,
              onTap: controller.pickSelfPhoto,
            ),
            SizedBox(height: 15.h),
            _imagePicker(
              label: "Upload Shop Photo",
              imagePath: controller.shopPhoto,
              onTap: controller.pickShopPhoto,
            ),
            SizedBox(height: 15.h),
            _imagePicker(
              label: "Upload Registration Document",
              imagePath: controller.docPhoto,
              onTap: controller.pickDocPhoto,
            ),
            SizedBox(height: 20.h),

            _textField(
              label: "Full Name",
              icon: Icons.person,
              controller: controller.fullname,
            ),
            SizedBox(height: 20.h),

            _textField(
              label: "Email",
              icon: Icons.email,
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),

            _textField(
              label: "Mobile Number",
              icon: Icons.phone,
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20.h),

            Obx(
              () => TextField(
                controller: controller.passwordController,
                obscureText: !controller.ispwvisible.value,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.teal, size: 22.sp),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.ispwvisible.value =
                          !controller.ispwvisible.value;
                    },
                    icon: Icon(
                      controller.ispwvisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            _textField(
              label: "Shop Name",
              icon: Icons.store,
              controller: controller.shopNameController,
            ),
            SizedBox(height: 20.h),

            Obx(
              () => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select Shop Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  prefixIcon: Icon(Icons.category, color: Colors.teal),
                ),
                initialValue: controller.selectedCategory.value,
                items: controller.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['id'],
                    child: Text(category['name']!),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedCategory.value = value;
                },
              ),
            ),
            SizedBox(height: 10.h),
            _textField(
              label: "Address",
              icon: Icons.location_on,
              controller: controller.addressController,
              // maxLines: 1,
            ),
            SizedBox(height: 20.h),
            _textField(
              label: "Referral Code or Sales Code",
              icon: Icons.inventory_outlined,
              controller: controller.referralController,
            ),
            SizedBox(height: 15.h),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          controller.isLoading.value = true;
                          await controller.register();
                          controller.isLoading.value = false;
                        },
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.8,
                          ),
                        )
                      : Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        prefixIcon: Icon(icon, color: Colors.teal, size: 22.sp),
      ),
    );
  }

  Widget _imagePicker({
    required String label,
    required RxString imagePath,
    required VoidCallback onTap,
  }) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.teal, width: 1.5),
            color: Colors.grey.shade100,
          ),
          child: imagePath.value.isEmpty
              ? Center(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 14.sp, color: Colors.teal),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    File(imagePath.value),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
      ),
    );
  }
}
