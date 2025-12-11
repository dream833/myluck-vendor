import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetpasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetpasswordController controller = Get.put(
      ForgetpasswordController(),
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.85.sw,
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Forget Password",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// Email
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Email", style: TextStyle(fontSize: 15.sp)),
                      ),
                      SizedBox(height: 5.h),

                      Obx(
                        () => TextField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            hintText: "user@gmail.com",
                            errorText: controller.emailError.value.isEmpty
                                ? null
                                : controller.emailError.value,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 15.w,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25.h),

                      /// Button
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.sendResetLink,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: controller.isLoading.value
                                ? SizedBox(
                                    height: 22.h,
                                    width: 22.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.black,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Send Reset Link",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}
