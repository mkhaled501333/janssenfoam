// // ignore_for_file: constant_identifier_names, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_order_view.dart';

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
  navigatorKey.currentState!
      .push(MaterialPageRoute(builder: (context) => const CuttingOrderView()));
}

initPushNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
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

class Constants {
  static const String BASE_URL = 'https://fcm.googleapis.com/fcm/send';
  static const String KEY_SERVER =
      'AAAAGLk7xJE:APA91bEUBE5A6Urimdobgk1tixMi40nxm75qJpNc2jcJZw6F3KTr6LT4EFOEDeOkCxtxfpWNm_rgM6FT3c6RmdUIfNFk8Au2Jgsx3AnP_Ou3hpWBAWazfQddJKSgb-erBTOOhLSZzCxF';
  static const String SENDER_ID = '106186917009';
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     // 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true,
//     description: AutofillHints.gender);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showesd up :  ${message.messageId}');
// }


// class MyHomePauuge extends StatefulWidget {
//    MyHomePauuge({super.key});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePauuge> {
//   int _counter = 0;

//   late TextEditingController _textToken;
//   late TextEditingController _textSetToken;
//   late TextEditingController _textTitle;
//   late TextEditingController _textBody;

//   @override
//   void dispose() {
//     _textToken.dispose();
//     _textTitle.dispose();
//     _textBody.dispose();
//     _textSetToken.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     super.initState();

//     _textToken = TextEditingController();
//     _textSetToken = TextEditingController();
//     _textTitle = TextEditingController();
//     _textBody = TextEditingController();

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification!.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(channel.id, channel.name,
//                   color: Colors.blue,
//                   playSound: true,
//                   icon: '@mipmap/ic_launcher'),
//             ));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Notifications'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 50),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _textToken,
//                       decoration: const InputDecoration(
//                           enabled: false,
//                           labelText: "My Token for this Device"),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: IconButton(
//                       icon: const Icon(Icons.copy),
//                       onPressed: () {
//                         Clipboard.setData(ClipboardData(text: _textToken.text));
//                       },
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 8),
//               TextButton(
//                 onPressed: () async {
//                   _textToken.text = await token();
//                 },
//                 child: const Text('Get Token'),
//               ),
//               TextField(
//                 controller: _textTitle,
//                 decoration: const InputDecoration(labelText: "Enter Title"),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _textBody,
//                 decoration: const InputDecoration(labelText: "Enter Body"),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _textSetToken,
//                 decoration: const InputDecoration(labelText: "Enter Token"),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         if (_textSetToken.text.isNotEmpty && check()) {
//                           pushNotificationsSpecificDevice(
//                             title: _textTitle.text,
//                             body: _textBody.text,
//                             token: _textSetToken.text,
//                           );
//                         }
//                       },
//                       child:
//                           const Text('Send Notification for specific Device'),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         if (check()) {
//                           pushNotificationsGroupDevice(
//                             title: _textTitle.text,
//                             body: _textBody.text,
//                           );
//                         }
//                       },
//                       child: const Text('Send Notification Group Device'),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         if (check()) {
//                           pushNotificationsAllUsers(
//                             title: _textTitle.text,
//                             body: _textBody.text,
//                           );
//                         }
//                       },
//                       child: const Text('Send Notification All Devices'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: showNotification,
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(
//             width: 16,
//           ),
//           FloatingActionButton(
//             onPressed: () async {
//               if (check()) {
//                 pushNotificationsAllUsers(
//                   title: _textTitle.text,
//                   body: _textBody.text,
//                 );
//               }
//             },
//             tooltip: 'Push Notifications',
//             child: const Icon(Icons.send),
//           )
//         ],
//       ),
//     );
//   }

//   Future<bool> pushNotificationsSpecificDevice({
//     required String token,
//     required String title,
//     required String body,
//   }) async {
//     String dataNotifications = '{ "to" : "$token",'
//         ' "notification" : {'
//         ' "title":"$title",'
//         '"body":"$body"'
//         ' }'
//         ' }';

//     await http.post(
//       Uri.parse(Constants.BASE_URL),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key= ${Constants.KEY_SERVER}',
//       },
//       body: dataNotifications,
//     );
//     return true;
//   }

//   Future<bool> pushNotificationsGroupDevice({
//     required String title,
//     required String body,
//   }) async {
//     String dataNotifications = '{'
//         '"operation": "create",'
//         '"notification_key_name": "appUser-testUser",'
//         '"registration_ids":["dV5pjB2aS_KAE1CuCrBPRG:APA91bHDjwDJbEBYVYtaBXdJ9hNHt2yNnoNhGU5k16AMvGcCFTAdK7h9GHWUu8rlthR8oQXbFJi5EBQQ1okFOZJC94m98manc6Or6CZr5TTDB-B8zzlMT1RrLzPakDg2kvM0Mir460bG","d1Kudv_ERRSY4ELxKjss-c:APA91bFMm-S56N35a6u8WAMiV88I3fNXKvhcLa8KbMrbjG7CdiVVCikJd3dyc0SgBkqlm3bsAJpU7rueX5esTYjOhILAUUNI8JXXZXDNXfWzi-wOWerYBfHFNR1JgL2N6c41iNJi8vaB"],'
//         '"notification" : {'
//         '"title":"$title",'
//         '"body":"$body"'
//         ' }'
//         ' }';

//     var response = await http.post(
//       Uri.parse(Constants.BASE_URL),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key= ${Constants.KEY_SERVER}',
//         'project_id': "${Constants.SENDER_ID}"
//       },
//       body: dataNotifications,
//     );

//     print(response.body.toString());

//     return true;
//   }

//   Future<bool> pushNotificationsAllUsers({
//     required String title,
//     required String body,
//   }) async {
//     // FirebaseMessaging.instance.subscribeToTopic("myTopic1");

//     String dataNotifications = '{ '
//         ' "to" : "/topics/myTopic1" , '
//         ' "notification" : {'
//         ' "title":"$title" , '
//         ' "body":"$body" '
//         ' } '
//         ' } ';

//     var response = await http.post(
//       Uri.parse(Constants.BASE_URL),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key= ${Constants.KEY_SERVER}',
//       },
//       body: dataNotifications,
//     );
//     print(response.body.toString());
//     return true;
//   }

//   Future<String> token() async {
//     return await FirebaseMessaging.instance.getToken() ?? "";
//   }

//   void showNotification() {
//     setState(() {
//       _counter++;
//     });
//     flutterLocalNotificationsPlugin.show(
//         0,
//         "Testing $_counter",
//         "How you doin ?",
//         NotificationDetails(
//             android: AndroidNotificationDetails(channel.id, channel.name,
//                 importance: Importance.high,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher')));
//   }

//   bool check() {
//     if (_textTitle.text.isNotEmpty && _textBody.text.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
// }




// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// // //   await Firebase.initializeApp();
// // //   print('Handling a background message ${message.messageId}');
// // //   print(message.data);
// // //   flutterLocalNotificationsPlugin.show(
// // //       message.data.hashCode,
// // //       message.data['title'],
// // //       message.data['body'],
// // //       NotificationDetails(
// // //         android: AndroidNotificationDetails(
// // //           channel.id,
// // //           channel.name,
// // //           channel.description,
// // //         ),
// // //       ));
// // // }

// // // const AndroidNotificationChannel channel = AndroidNotificationChannel(
// // //   'high_importance_channel', // id
// // //   'High Importance Notifications', // title
// // //   'This channel is used for important notifications.', // description
// // //   importance: Importance.high,
// // // );

// // // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// // //     FlutterLocalNotificationsPlugin();

// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Firebase.initializeApp();

// // //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// // //   await flutterLocalNotificationsPlugin
// // //       .resolvePlatformSpecificImplementation<
// // //           AndroidFlutterLocalNotificationsPlugin>()
// // //       ?.createNotificationChannel(channel);

// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatefulWidget {
// // //   @override
// // //   _MyAppState createState() => _MyAppState();
// // // }

// // // class _MyAppState extends State<MyApp> {
// // //   String token;
// // //   List subscribed = [];
// // //   List topics = [
// // //     'Samsung',
// // //     'Apple',
// // //     'Huawei',
// // //     'Nokia',
// // //     'Sony',
// // //     'HTC',
// // //     'Lenovo'
// // //   ];
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     var initialzationSettingsAndroid =
// // //         const AndroidInitializationSettings('@mipmap/ic_launcher');
// // //     var initializationSettings =
// // //         InitializationSettings(android: initialzationSettingsAndroid);

// // //     flutterLocalNotificationsPlugin.initialize(initializationSettings);
// // //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// // //       RemoteNotification notification = message.notification;
// // //       AndroidNotification android = message.notification?.android;
// // //       if (notification != null && android != null) {
// // //         flutterLocalNotificationsPlugin.show(
// // //             notification.hashCode,
// // //             notification.title,
// // //             notification.body,
// // //             NotificationDetails(
// // //               android: AndroidNotificationDetails(
// // //                 channel.id,
// // //                 channel.name,
// // //                 channel.description,
// // //                 icon: android?.smallIcon,
// // //               ),
// // //             ));
// // //       }
// // //     });
// // //     getToken();
// // //     getTopics();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: Scaffold(
// // //           appBar: AppBar(
// // //             title: const Text('appbar'),
// // //           ),
// // //           body: ListView.builder(
// // //             itemCount: topics.length,
// // //             itemBuilder: (context, index) => ListTile(
// // //               title: Text(topics[index]),
// // //               trailing: subscribed.contains(topics[index])
// // //                   ? ElevatedButton(
// // //                       onPressed: () async {
// // //                         await FirebaseMessaging.instance
// // //                             .unsubscribeFromTopic(topics[index]);
// // //                         await FirebaseFirestore.instance
// // //                             .collection('topics')
// // //                             .doc(token)
// // //                             .update({topics[index]: FieldValue.delete()});
// // //                         setState(() {
// // //                           subscribed.remove(topics[index]);
// // //                         });
// // //                       },
// // //                       child: const Text('unsubscribe'),
// // //                     )
// // //                   : ElevatedButton(
// // //                       onPressed: () async {
// // //                         await FirebaseMessaging.instance
// // //                             .subscribeToTopic(topics[index]);

// // //                         await FirebaseFirestore.instance
// // //                             .collection('topics')
// // //                             .doc(token)
// // //                             .set({topics[index]: 'subscribe'},
// // //                                 SetOptions(merge: true));
// // //                         setState(() {
// // //                           subscribed.add(topics[index]);
// // //                         });
// // //                       },
// // //                       child: const Text('subscribe')),
// // //             ),
// // //           )),
// // //     );
// // //   }

// // //   getToken() async {
// // //     token = (await FirebaseMessaging.instance.getToken())!;
// // //     setState(() {
// // //       token = token;
// // //     });
// // //     print(token);
// // //   }

// // //   getTopics() async {
// // //     await FirebaseFirestore.instance
// // //         .collection('topics')
// // //         .get()
// // //         .then((value) => value.docs.forEach((element) {
// // //               if (token == element.id) {
// // //                 subscribed = element.data().keys.toList();
// // //               }
// // //             }));

// // //     setState(() {
// // //       subscribed = subscribed;
// // //     });
// // //   }
// // // }