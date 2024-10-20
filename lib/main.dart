import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/notification.dart';
import 'package:janssenfoam/ui/auth/login.dart';
import 'package:janssenfoam/ui/auth/users_controllers.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/blocks/addCategoreys/CategorysController.dart';
import 'ui/chemical_stock/ChemicalsController.dart';
import 'ui/customers/Customer_controller.dart';
import 'ui/cutting_order/Order_controller.dart';
import 'controllers/bFractionsController.dart';
import 'controllers/bSubfractions.dart';
import 'ui/blocks/blockFirebaseController.dart';
import 'controllers/dropDowen_controller.dart';
import 'ui/finalProdcuts/final_product_controller.dart';
import 'ui/finalProdcuts/invoices/invoice_controller.dart';
import 'ui/not_final/non_final_controller.dart';
import 'ui/purching/purchesController.dart';
import 'controllers/setting_controller.dart';
import 'ui/stockCheck/stockCheckController.dart';
import 'controllers/zupdate.dart';
import 'package:provider/provider.dart';
import 'controllers/ObjectBoxController.dart';
import 'controllers/main_controller.dart';
import 'ui/scissors/scissors_controller.dart';
import 'ui/main/main_view.dart';

DateFormat format = DateFormat('yyyy/MM/dd');
DateFormat formatwitTime = DateFormat('yyyy-MM-dd/hh:mm a');
DateFormat formatwitTime2 = DateFormat('yyyy-MM-dd -hh:mm a');
DateFormat formatwitTime3 = DateFormat('hh:mm a');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAkWHl9E0KfHcvf5Ifx0WVvEXuvk2URhhs",
          appId: "1:106186917009:android:fcd892c86b7d3e3447ab30",
          messagingSenderId: "106186917009",
          projectId: "janson-11f24"));

  FirebaseDatabase.instance.setPersistenceEnabled(true);

  // Initialize shared preferences
  prefs = await SharedPreferences.getInstance();

  if (Platform.isAndroid) {
    initPushNotification();
  }

  runApp(MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final bool initionlized = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MainController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ScissorsController(),
          ),
          ChangeNotifierProvider(
            create: (context) => Hivecontroller(),
          ),
          ChangeNotifierProvider(
            create: (context) => ObjectBoxController(),
          ),
          ChangeNotifierProvider(
            create: (context) => SettingController(),
          ),
          ChangeNotifierProvider(
            create: (context) => final_prodcut_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => UpdatesController(),
          ),
          ChangeNotifierProvider(
            create: (context) => BlockFirebasecontroller(),
          ),
          ChangeNotifierProvider(
            create: (context) => NonFinalController(),
          ),
          ChangeNotifierProvider(
            create: (context) => Invoice_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Customer_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderController(),
          ),
          ChangeNotifierProvider(
            create: (context) => dropDowenContoller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Users_controller()..assignValOF_internet(),
          ),
          ChangeNotifierProvider(
            create: (context) => Category_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Chemicals_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => PurchesController(),
          ),
          ChangeNotifierProvider(
            create: (context) => Fractions_Controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => SubFractions_Controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => StokCheck_Controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => IndusterialSecuritycontroller(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(useMaterial3: false),
          debugShowCheckedModeBanner: false,
          home: Consumer<Users_controller>(
            builder: (context, myType, child) {
              return currentuser == null ? MyloginPage() : Mainview();
            },
          ),
        ));
  }
}

class Commons {
  static const tileBackgroundColor = Color(0xFFF1F1F1);
  static const chuckyJokeBackgroundColor = Color(0xFFF1F1F1);
  static const chuckyJokeWaveBackgroundColor = Color(0xFFA8184B);
  static const gradientBackgroundColorEnd = Color(0xFF601A36);
  static const gradientBackgroundColorWhite = Color(0xFFFFFFFF);
  static const mainAppFontColor = Color(0xFF4D0F29);
  static const appBarBackGroundColor = Color(0xFF4D0F28);
  static const categoriesBackGroundColor = Color(0xFFA8184B);
  static const hintColor = Color(0xFF4D0F29);
  static const mainAppColor = Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = Color(0xFF4D0F29);
  static const popupItemBackColor = Color(0xFFDADADB);
  static List<Color> dashColor = [
    const Color(0xff1AB0B0),
    const Color(0xffFF7544),
    const Color(0xffFA5A7D),
    const Color(0xff8676FE)
  ];
}
