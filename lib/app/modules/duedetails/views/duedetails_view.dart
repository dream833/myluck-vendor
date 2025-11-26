import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/duedetails_controller.dart';

class DuedetailsView extends GetView<DuedetailsController> {
  const DuedetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Due Details"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.dueList.isEmpty) {
          return const Center(child: Text("No Due Payments Found."));
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.dueList.length,
          itemBuilder: (context, index) {
            final pkg = controller.dueList[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 3,
              margin: EdgeInsets.only(bottom: 12.h),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pkg["package_title"] ?? "N/A",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "${pkg["balance_type"] ?? ''} - ₹${pkg["price"]}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Added: ${pkg["created_at"] ?? ''}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    // Right side button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () => controller.payNow(pkg),
                      child: const Text(
                        "Pay Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
