import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Profile Photo
              CircleAvatar(
                radius: 50.sp,
                backgroundImage: controller.selfPhoto.value.isNotEmpty
                    ? NetworkImage(controller.selfPhoto.value)
                    : const AssetImage('assets/images/user_placeholder.png')
                          as ImageProvider,
              ),
              SizedBox(height: 16.h),

              // 🔹 Shop Photo
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: controller.shopPhoto.value.isNotEmpty
                    ? Image.network(
                        controller.shopPhoto.value,
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 120.h,
                        color: Colors.teal.shade50,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.store,
                          color: Colors.teal,
                          size: 40,
                        ),
                      ),
              ),
              SizedBox(height: 24.h),

              // 🔹 Info Fields
              _buildInfoRow("Name", controller.name.value),
              _buildInfoRow("Shop Name", controller.shopName.value),
              _buildInfoRow("Email", controller.email.value),
              _buildInfoRow("Phone", controller.phone.value),
              _buildInfoRow(
                "Address",
                controller.address.value.isEmpty
                    ? "N/A"
                    : controller.address.value,
              ),

              SizedBox(height: 30.h),

              // 🔹 Save Button
              // ElevatedButton.icon(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.teal,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12.r),
              //     ),
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 32.w,
              //       vertical: 14.h,
              //     ),
              //   ),
              //   onPressed: () {
              //     Get.snackbar(
              //       "Coming Soon",
              //       "Profile edit functionality will be added soon!",
              //       backgroundColor: Colors.teal,
              //       colorText: Colors.white,
              //     );
              //   },
              //   icon: const Icon(Icons.save, color: Colors.white),
              //   label: const Text(
              //     "",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.label_important, color: Colors.teal.shade400, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.teal.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value.isEmpty ? "N/A" : value,
                  style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
