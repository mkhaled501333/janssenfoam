import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_order_view.dart';

class FirebaseApi {
  static initializeNOtification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static initPushNotification() {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        // 'This channel is used for important notifications.', // description
        importance: Importance.high,
        playSound: true,
        sound: UriAndroidNotificationSound("default"),
        description: AutofillHints.gender);

    Future<void> messagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
    }

    final localanotification = FlutterLocalNotificationsPlugin();
    void handleMassage(RemoteMessage? massage) {
      if (massage == null) return;
      navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const CuttingOrderView()));
    }

    initPushNotification() async {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.instance.subscribeToTopic("myTopic1");
      FirebaseMessaging.instance.getInitialMessage().then(handleMassage);
      FirebaseMessaging.onMessageOpenedApp.listen(handleMassage);
      FirebaseMessaging.onBackgroundMessage(messagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen((event) {
        final notificatin = event.notification;
        if (notificatin == null) return;
        localanotification.show(
            notificatin.hashCode,
            notificatin.title,
            notificatin.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
            )));
      });
    }
  }
}
