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
    BottomNavigationBarItem(icon: Icon(Icons.redeem), label: 'Transactions'),
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
      () => Scaffold(
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
    );
  }
}
