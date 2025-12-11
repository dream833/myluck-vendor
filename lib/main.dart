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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔥 Background Message: ${message.messageId}");
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
    Get.put(LoginController());
    Get.put(NotificationService());
  }
}

// 🔥 ALWAYS PRINT NEW TOKEN
Future<String?> loadFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("🔥 FCM TOKEN: $token");
  return token;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);
  print("🔔 Permission: ${settings.authorizationStatus}");

  await NotificationService().initNotification();

  await loadFCMToken();

  await GetStorage.init();
  final box = GetStorage();

  // 🔹 Subscribe to 'allusers' topic only once
  bool isSubscribed = box.read('IS_SUBSCRIBED_ALLUSERS') ?? false;
  if (!isSubscribed) {
    await FirebaseMessaging.instance.subscribeToTopic("allusers");
    print("✅ Subscribed to allusers topic");
    box.write('IS_SUBSCRIBED_ALLUSERS', true);
  } else {
    print("ℹ️ Already subscribed to allusers topic");
  }

  final isLoggedIn = box.read('IS_USER_LOGGED_IN') ?? false;

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Myluck Vendor",
          theme: ThemeData(primarySwatch: Colors.teal),
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
