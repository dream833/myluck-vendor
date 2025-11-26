import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:rewardvendor/app/modules/Qrscannerpage/views/qrscannerpage_view.dart';
import 'package:rewardvendor/app/modules/assign_point/controllers/assign_point_controller.dart';

class AssignPointView extends StatelessWidget {
  const AssignPointView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssignPointController());

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Assign Reward Points",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔍 Search field + QR button
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: "Enter Customer Code",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () => Get.to(() => QrscannerpageView()),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // 🔘 Search button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: controller.searchCustomer,
                  child: Text(
                    "Search Customer",
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // 👤 Customer details card
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator(color: Colors.teal);
                }

                if (!controller.isCustomerLoaded.value) {
                  return Text(
                    "No customer selected",
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  );
                }

                final data = controller.customerData;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${data['name']}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Customer Code: ${data['customer_code']}",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 20.h),

              // ⭐ Star input
              TextField(
                controller: controller.starController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter Stars",
                  prefixIcon: const Icon(Icons.star, color: Colors.amber),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // 🪙 Coin input
              TextField(
                controller: controller.coinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter Coins",
                  prefixIcon: const Icon(
                    Icons.monetization_on,
                    color: Colors.orange,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // 🚀 Assign reward button
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
                        : controller.assignReward,
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            value: 20.sp,
                          )
                        : Text(
                            "Assign Reward",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
