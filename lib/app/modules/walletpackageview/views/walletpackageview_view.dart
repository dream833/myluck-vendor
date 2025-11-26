import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controllers/walletpackageview_controller.dart';

class WalletpackageviewView extends GetView<WalletpackageviewController> {
  const WalletpackageviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletpackageviewController());

    final gradients = [
      [Colors.teal, Colors.greenAccent],
      [Colors.deepPurple, Colors.purpleAccent],
      [Colors.orange, Colors.deepOrangeAccent],
      [Colors.indigo, Colors.blueAccent],
      [Colors.pinkAccent, Colors.redAccent],
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Top Up Packages",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }

        if (controller.packages.isEmpty) {
          return Center(
            child: Text(
              "No Packages Available",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: List.generate(controller.packages.length, (index) {
              final pkg = controller.packages[index];
              final isStar = pkg["balance_type"] == "Star";

              final gradientColors = gradients[index % gradients.length];

              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors.last.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.rotate(
                        angle: -math.pi / 40,
                        child: Icon(
                          isStar
                              ? Icons.star_rounded
                              : Icons.monetization_on_rounded,
                          color: Colors.white,
                          size: 45.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        pkg["package_title"] ?? "",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${pkg["balance_quantity"]} ${pkg["balance_type"]}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "₹${pkg["price"]}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 38.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controller.startPayment(pkg);
                        },
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: gradientColors.first,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
