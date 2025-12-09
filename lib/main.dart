import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app/data/function/notification_service.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/Login/controllers/login_controller.dart';
import 'app/modules/edit_profile/controllers/edit_profile_controller.dart';

// 🔥 BACKGROUND NOTIFICATION HANDLER
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background Message: ${message.messageId}");
}

// 🔹 INITIAL BINDINGS
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
    Get.put(LoginController());
    Get.put(NotificationService());
  }
}

// 🔹 PRINT FCM TOKEN
Future<void> getFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("🔥 FCM Token: $token");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await getFCMToken();
  log(getFCMToken().toString());

  await NotificationService().initNotification();

  await GetStorage.init();
  final box = GetStorage();
  final isLoggedIn = box.read('IS_USER_LOGGED_IN') ?? false;

  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);
  print("User Notification Permission: ${settings.authorizationStatus}");

  // 🔹 Run App
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

          initialBinding: InitialBindings(),

          initialRoute: isLoggedIn
              ? Routes.BOTTOM_NAVIGATION_BAR
              : Routes.LOGIN,

          getPages: AppPages.routes,
        );
      },
    ),
  );
}
