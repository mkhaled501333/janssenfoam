import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/color_manager.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/Statistics/view.dart';
import 'package:janssenfoam/ui/auth/users_controllers.dart';
import 'package:janssenfoam/ui/blocks/blocksView.dart';
import 'package:janssenfoam/ui/finalProdcuts/FinalProdcutsView.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityView.dart';
import '../../app/extentions.dart';
import '../chemical_stock/ChemicalStock_view.dart';
import '../../core/commen/claculator.dart';
import '../customers/customersView.dart';
import '../cutting_order/cutting_order_view.dart';
import '../finalProdcuts/final_product_imported/improtedFinalProduct_view.dart';
import '../main/componants/item_widget.dart';
import '../not_final/not_final_view.dart';
import '../purching/purching_view.dart';

import '../scissors/scissorsview/scissors_view.dart';
import '../stockCheck/stockcheck.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Users_controller>(
      builder: (context, myType, child) {
        return SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c1,
                    " الكيماويات",
                    1,
                    ontap: () {
                      context.gonext(context, const Chemical_view());
                    },
                  ).permition(context, UserPermition.show_chemicals_model),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c2,
                    "البلوكات",
                    2,
                    ontap: () {
                      context.gonext(context, blocksView());
                    },
                  ).permition(context, UserPermition.show_block_incetion),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c3,
                    "المنتج التام",
                    3,
                    ontap: () {
                      context.gonext(context, const FinalProdcutsModule());
                    },
                  ).permition(context, UserPermition.show_finalProdcut_stock),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c4,
                    "انتاج المقصات",
                    4,
                    ontap: () {
                      context.gonext(context, const FinalProductView());
                    },
                  ).permition(context,
                      UserPermition.show_finalprodcut_importedFormcuttingUint),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c5,
                    "مخزن دون التام",
                    5,
                    ontap: () {
                      context.gonext(context, const NotFinal());
                    },
                  ).permition(context, UserPermition.show_not_final_stock),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c6,
                    "قوائم الجرد",
                    6,
                    ontap: () {
                      context.gonext(context, Stockcheck());
                    },
                  ).permition(context, UserPermition.show_stcokCheck_moldule),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c7,
                    " المقصات",
                    7,
                    ontap: () {
                      context.gonext(context, const ScissorsView());
                    },
                  ).permition(context, UserPermition.show_scissors),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    Colorpallete.c8,
                    " الاله الحسابه",
                    8,
                    ontap: () {
                      context.gonext(context, const Calculator());
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xffFA5A7D),
                    "اوامر التشغيل",
                    9,
                    ontap: () {
                      context.gonext(context, const CuttingOrderView());
                    },
                  ).permition(context, UserPermition.show_cutting_orders),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.teal,
                    "العملاء",
                    10,
                    ontap: () {
                      context.gonext(context, Customers_view());
                    },
                  ).permition(context, UserPermition.show_customers),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 47, 105, 42),
                    " الاحصائيات",
                    11,
                    ontap: () {
                      context.gonext(context, const Statistics());
                    },
                  ).permition(context, UserPermition.not_working),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 143, 32, 32),
                    " الامن الصناعى",
                    12,
                    ontap: () {
                      context.gonext(context, InsusterialSecurityView());
                    },
                  ).permition(context, UserPermition.Industrial_Security),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.prussianBlue,
                    " المشتريات",
                    13,
                    ontap: () {
                      context.gonext(context, const PurchVeiw());
                    },
                  ).permition(context, UserPermition.Show_purches_module),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 157, 125, 45),
                    "الاوردرات الاونلاين",
                    14,
                    ontap: () {},
                  ).permition(context, UserPermition.online_orders),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.blueGrey,
                    "المراسله والطلبات",
                    15,
                    ontap: () {},
                  ).permition(context, UserPermition.chat),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 99, 26, 73),
                    "ادارة العهد",
                    16,
                    ontap: () async {},
                  ).permition(context, UserPermition.show_Ohda_management),
                ],
              ),
            ].reversed.toList(),
          ),
        );
      },
    );
  }
}

class Colorpallete {
  static final c1 = const Color.fromARGB(255, 52, 78, 65);
  static final c2 = const Color.fromARGB(255, 58, 90, 64);
  static final c3 = const Color.fromARGB(255, 88, 129, 87);
  static final c4 = const Color.fromARGB(255, 163, 177, 138);
  static final c5 = const Color.fromARGB(255, 65, 93, 67);
  static final c6 = const Color.fromARGB(255, 55, 61, 32);
  static final c7 = const Color.fromARGB(255, 113, 119, 68);
  static final c8 = const Color.fromARGB(255, 188, 189, 139);
}
