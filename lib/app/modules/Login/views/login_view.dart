import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  /// Email / Mobile
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Mobile Number Or Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.teal,
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),

                  /// Password
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.teal,
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Login Button + Loader
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
                            : () async {
                                controller.isLoading.value = true;
                                await controller.login();
                                controller.isLoading.value = false;
                              },
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.8,
                                ),
                              )
                            : Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(('/forget-password'));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// Signup Text
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.teal, fontSize: 14.sp),
                      ),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
