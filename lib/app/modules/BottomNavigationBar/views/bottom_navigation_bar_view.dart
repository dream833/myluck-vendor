import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/modules/BottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';
import 'package:rewardvendor/app/modules/Transaction/views/transaction_view.dart';
import 'package:rewardvendor/app/modules/home/views/home_view.dart';
import 'package:rewardvendor/app/modules/profile/views/profile_view.dart';
import 'package:shimmer/shimmer.dart';

class BottomNavigationBarView extends StatelessWidget {
  final BottomnavigationbarController controller = Get.put(
    BottomnavigationbarController(),
  );

  final List<Widget> pages = [HomeView(), TransactionView(), ProfileView()];

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.redeem), label: 'Transaction'),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.storefront_outlined),
    //   label: 'Orders',
    // ),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];

  BottomNavigationBarView({super.key});

  Widget shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          child: Container(height: 100.h, color: Colors.grey.shade300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          bool exitApp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.teal,
                        size: 42.sp,
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Title
                    Text(
                      "Exit App?",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Description
                    Text(
                      "Are you sure you want to close the application?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.teal.shade600,
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              backgroundColor: Colors.teal.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),

                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(
                              "Yes, Exit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

          return exitApp;
        },
        child: Scaffold(
          body: controller.isLoading.value
              ? shimmerPlaceholder()
              : pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
            onTap: controller.changeTabIndex,
            items: items,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
