import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.storefront, color: Colors.white, size: 26.sp),
            SizedBox(width: 10.w),
            Text("Dashboard",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: Icon(Icons.person, size: 26.sp, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Management
            _buildSectionHeader("Transaction Management"),
            Row(
              children: [
                _buildCard(
                  title: "View Transactions",
                  icon: Icons.receipt_long,
                  onTap: () => Get.toNamed("/transaction"),
                  color1: Colors.teal,
                  color2: Colors.teal.shade400,
                ),
                SizedBox(width: 12.w),
                _buildCard(
                  title: "Assign Points",
                  icon: Icons.add_task,
                  onTap: () => Get.toNamed("/transaction"),
                  color1: Colors.orange,
                  color2: Colors.deepOrange,
                ),
              ],
            ),
            SizedBox(height: 22.h),

            // Recognition & Competition
            _buildSectionHeader("Recognition & Competition"),
            Row(
              children: [
                _buildCard(
                  title: "Leaderboard",
                  icon: Icons.emoji_events,
                  onTap: () => Get.toNamed("/leaderboard"),
                  color1: Colors.blue,
                  color2: Colors.indigo,
                ),
                SizedBox(width: 12.w),
                _buildCard(
                  title: "Monthly Reward",
                  icon: Icons.card_giftcard,
                  onTap: controller.checkRewardEligibility,
                  color1: Colors.purple,
                  color2: Colors.deepPurple,
                ),
              ],
            ),
            SizedBox(height: 22.h),

            // First-Time Purchase
            _buildSectionHeader("First-Time Purchase Policy"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                gradient: LinearGradient(
                  colors: [Colors.teal.shade50, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Obx(() => Text(
                    controller.firstTimeStatus.value,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(height: 22.h),

            // Monthly Credit Status
            _buildSectionHeader("Monthly Credit Status"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                gradient: LinearGradient(
                  colors: [Colors.teal.shade50, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Credit Balance: ₹${controller.creditBalance.value}",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      SizedBox(height: 6.h),
                      Text("Unpaid Credits: ₹${controller.unpaidCredits.value}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: controller.unpaidCredits.value > 0
                                ? Colors.red
                                : Colors.green,
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
          Container(
            height: 2,
            width: 60.w,
            color: Colors.teal,
          )
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color1,
    required Color color2,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: color1.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(2, 4),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 28.sp, color: color1),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
