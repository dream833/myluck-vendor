import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/notification_page_controller.dart';

class NotificationPageView extends GetView<NotificationPageController> {
  const NotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8), // 🔥 Light background

      appBar: AppBar(
        backgroundColor: Colors.teal, // 🔥 Teal AppBar
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }

        if (controller.list.isEmpty) {
          return Center(
            child: Text(
              "No Notifications Found",
              style: TextStyle(fontSize: 18.sp, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          itemCount: controller.list.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),

          itemBuilder: (context, index) {
            final item = controller.list[index];

            return Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: Colors.grey.shade300, width: 0.7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔥 Title
                  Text(
                    item.title ?? "",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal.shade700,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // 🔥 Message
                  Text(
                    item.message ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // 🔥 Thin divider line for nice look
                  Divider(color: Colors.grey.shade300, height: 15),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
