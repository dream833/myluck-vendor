import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewardvendor/app/modules/notification_page/controllers/notification_page_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    var notic = Get.put((NotificationPageController()));

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
            Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: Icon(Icons.person, size: 26.sp, color: Colors.white),
          ),

          // 🔔 Notification with badge counter
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed("/notification-page");
                },
                icon: Icon(
                  Icons.notifications,
                  size: 26.sp,
                  color: Colors.white,
                ),
              ),

              // ⭐ Dynamic Badge using GetX
              Positioned(
                right: 6,
                top: 6,
                child: Obx(() {
                  final int count = notic.total.value;

                  // ⭐ Hide badge if zero
                  if (count == 0) return const SizedBox();

                  return Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18.w,
                      minHeight: 18.w,
                    ),
                    child: Text(
                      count > 9 ? "9+" : count.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Transaction Management
            _buildSectionHeader("Transaction Management"),
            Row(
              children: [
                _buildCard(
                  title: "Wallet-Balance",
                  icon: Icons.receipt_long,
                  onTap: () => Get.toNamed("/walletbalance"),
                  color1: Colors.teal,
                  color2: Colors.teal.shade400,
                ),
                SizedBox(width: 12.w),
                _buildCard(
                  title: "Assign-Points",
                  icon: Icons.add_task,
                  onTap: () => Get.toNamed("/assign-point"),
                  color1: Colors.orange,
                  color2: Colors.deepOrange,
                ),
              ],
            ),
            SizedBox(height: 50.h),

            // 🔹 Recognition & Competition
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
            SizedBox(height: 55.h),

            _buildSectionHeader("Monthly Credit Status"),

            Obx(
              () => RefreshIndicator(
                color: Colors.teal,
                onRefresh: () async {
                  await controller.fetchCreditData();
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade100, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.teal.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade100.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🟢 Left side info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Credit Balance",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "₹${controller.creditBalance.value}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                controller.unpaidCredits.value > 0
                                    ? "Unpaid: ${controller.unpaidCredits.value}"
                                    : "No Pending Dues",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: controller.unpaidCredits.value > 0
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/duedetails');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.teal.shade700,
                                    Colors.teal.shade400,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "View Details",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🧱 Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Container(height: 2, width: 60.w, color: Colors.teal),
        ],
      ),
    );
  }

  /// 🧱 Reusable Dashboard Card
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
              ),
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
                    color: Colors.white,
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
