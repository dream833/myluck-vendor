import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/modules/Login/controllers/login_controller.dart';
import 'package:rewardvendor/app/modules/walletbalance/controllers/walletbalance_controller.dart';

class WalletbalanceView extends StatelessWidget {
  const WalletbalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletbalanceController());
    controller.fetchWalletBalance();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Wallet-Balance"),
        centerTitle: true,
        elevation: 2,
      ),
      body: RefreshIndicator(
        color: Colors.teal,
        onRefresh: () async {
          await controller.fetchWalletBalance();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),

              // 🔥 Balance Card from WalletbalanceController
              Obx(() {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "${controller.totalbalance.value}",
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _balanceChip(
                            Icons.star,
                            "Stars",
                            controller.totalStars.value,
                          ),
                          SizedBox(width: 12.w),
                          _balanceChip(
                            Icons.monetization_on,
                            "Coins",
                            controller.totalCoins.value,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: 20.h),

              // 🔹 Top Up Button
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/walletpackageview');
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Top Up",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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

  Widget _balanceChip(IconData icon, String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          const SizedBox(width: 6),
          Text("$value $label", style: const TextStyle(color: Colors.teal)),
        ],
      ),
    );
  }
}
