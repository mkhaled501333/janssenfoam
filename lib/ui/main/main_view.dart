import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/core/commen/serverStatues.dart';
import 'package:janssenfoam/core/recources/color_manager.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/auth/users_controllers.dart';
import 'package:janssenfoam/ui/stockCheck/stockCheckController.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';
import '../../app/functions.dart';
import '../blocks/addCategoreys/CategorysController.dart';
import '../chemical_stock/ChemicalsController.dart';
import '../customers/Customer_controller.dart';
import '../cutting_order/Order_controller.dart';

import '../blocks/blockFirebaseController.dart';
import '../finalProdcuts/final_product_controller.dart';
import '../finalProdcuts/invoices/invoice_controller.dart';

import 'componants/nav_bar.dart';
import '../../controllers/main_controller.dart';
import 'main_viewModel.dart';

import 'package:provider/provider.dart';

class Mainview extends StatelessWidget {
  Mainview({
    super.key,
  });

  final MainViewModel vm = MainViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Users_controller>(
      builder: (context, myType, child) {
        print("refesh home  Users_controller");
        getModulesData(context);

        return Scaffold(
          backgroundColor: ColorManager.gallery,
          appBar: AppBar(
            title: Consumer<MainController>(
              builder: (context, myType, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("طريقة الاتصال : ${internet ? 'الانترنت' : 'السيرفر'}",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black)),
                    const ServerStutus(),
                  ],
                );
              },
            ),
          ),
          body: Consumer<MainController>(
            builder: (context, controller, child) {
              return vm.screens[controller.currentIndex];
            },
          ),
          bottomNavigationBar: NavBar(),
        );
      },
    );
  }
}

void getModulesData(BuildContext context) {
  if (initialized == false) {
    initialized = true;
    context.read<Hivecontroller>().getdata();
    if (permitionss(context, UserPermition.can_get_data_of_blocks)) {
      context.read<BlockFirebasecontroller>().getData();
      context.read<Category_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_orders)) {
      context.read<OrderController>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_customers)) {
      context.read<Customer_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_chemicals)) {
      context.read<Chemicals_controller>().getdata();
    }
    if (permitionss(context, UserPermition.can_get_data_of_final_prodcut)) {
      context.read<final_prodcut_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_invoice)) {
      context.read<Invoice_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_stcokCheck)) {
      context.read<StokCheck_Controller>().get_StokCheck_data();
    }
    if (permitionss(context, UserPermition.Industrial_Security)) {
      context.read<IndusterialSecuritycontroller>().getdata();
    }
    if (Platform.isAndroid) {
      if (permitionss(
          context, UserPermition.show_cutting_order_notifications)) {
        FirebaseMessaging.instance.subscribeToTopic("myTopic1");
      } else {
        FirebaseMessaging.instance.unsubscribeFromTopic("myTopic1");
      }
    }
  }
}
