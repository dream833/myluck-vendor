import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // ⬇️ Initialize Notification Service
  Future<void> initNotification() async {
    await _firebaseInit();
    await _initLocalNotifications();
    await _setupInteractedMessage();
    _listenFCMMessages();
  }

  // ⬇️ Firebase Permission + Token
  Future<void> _firebaseInit() async {
    NotificationSettings settings = await _firebaseMessaging
        .requestPermission();
    print("🔔 User Permission: ${settings.authorizationStatus}");

    String? token = await _firebaseMessaging.getToken();
    print("🔥 FCM Token: $token");
  }

  // ⬇️ Local Notification Setup
  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const initSettings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(initSettings);
  }

  // ⬇️ Show Local Notification
  Future<void> showLocalNotification(RemoteMessage msg) async {
    const android = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const ios = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(android: android, iOS: ios);

    await _localNotifications.show(
      0,
      msg.notification?.title ?? "No Title",
      msg.notification?.body ?? "No Message",
      notificationDetails,
    );
  }

  // ⬇️ Listen Foreground Messages
  void _listenFCMMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Message Received");
      showLocalNotification(message);
    });
  }

  // ⬇️ When App Opened By Notification
  Future<void> _setupInteractedMessage() async {
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();

    if (initialMessage != null) {
      print("🚀 App opened from TERMINATED");
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📌 Notification Clicked (Background)");
    });
  }
}
