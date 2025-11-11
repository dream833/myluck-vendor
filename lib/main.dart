import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rewardvendor/app/modules/Login/controllers/login_controller.dart';
import 'package:rewardvendor/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:rewardvendor/app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // 🔹 Initialize storage
  final box = GetStorage();

  Get.put(EditProfileController());
  Get.put(LoginController());

  final isLoggedIn = box.read('IS_USER_LOGGED_IN') ?? false;

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Reward Vendor",
          theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          initialRoute: isLoggedIn
              ? Routes.BOTTOM_NAVIGATION_BAR
              : Routes.LOGIN,

          // 🔹 All app pages
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
