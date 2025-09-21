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
        title: Text("Sign Up", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
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
              TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.teal, size: 22.sp),
              ),
            ),
            SizedBox(height: 20.h,),
              TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.teal, size: 22.sp),
              ),
            ),
                SizedBox(height: 20.h,),
              TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: Icon(Icons.password, color: Colors.teal, size: 22.sp),
            suffixIcon: Icon(Icons.visibility_rounded)
              ),
            ),
            SizedBox(height: 20.h,),
            TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: Icon(Icons.phone, color: Colors.teal, size: 22.sp),
              ),
            ),
            SizedBox(height: 15.h),

            TextField(
              controller: controller.referralController,
              decoration: InputDecoration(
                labelText: "Sales Team Code / Referral",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: Icon(Icons.code, color: Colors.teal, size: 22.sp),
              ),
            ),
            SizedBox(height: 25.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: controller.register,
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
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
                  child: Text(label,
                      style: TextStyle(fontSize: 14.sp, color: Colors.teal),),
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