// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, file_names, non_constant_identifier_names
// ignore_for_file: library_private_types_in_public_api, unused_local_variable
import 'package:flutter/material.dart';

import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/color_manager.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/Users_dashboard/users_dashbord.dart';
import 'package:janssenfoam/ui/auth/SignUp.dart';
import 'package:janssenfoam/ui/auth/login.dart';
import 'package:janssenfoam/ui/auth/users_controllers.dart';

import 'package:janssenfoam/ui/blocks/IN/outofStock_viewmoder.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/main/componants/item_widget.dart';
import 'package:janssenfoam/ui/main/main_view.dart';

import 'package:janssenfoam/ui/scissors/reportsforH/h_reports_viewModel.dart';
import 'package:janssenfoam/ui/users_actions/users_actios.dart';
import 'package:provider/provider.dart';

class Setings extends StatelessWidget {
  Setings({super.key});
  HReportsViewModel vm1 = HReportsViewModel();
  HReportsViewModel vm2 = HReportsViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        errmsg(context),
        ElevatedButton(
            onPressed: () {
              context.gonext(context, MyloginPage());
            },
            child: const Text("تسجيل الدخول")),
        currentuser!.email == "m.khaled"
            ? ElevatedButton(
                onPressed: () {
                  context.gonext(context, SignupPage());
                },
                child: const Text("تسجيل مستخدم جديد"))
            : const SizedBox(),
        currentuser!.email == "m.khaled" ? Text(ip) : const SizedBox(),
        Consumer<Users_controller>(
          builder: (context, myType, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اختر طريقة االاتصال',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Radio(
                        value: true,
                        groupValue: internet,
                        onChanged: (onChanged) {
                          myType.changeValOf_internet(onChanged!);
                          initialized = false;
                          internet = true;
                          getModulesData(context);
                        }),
                    const Text('الانترنت')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: false,
                        groupValue: internet,
                        onChanged: (onChanged) {
                          myType.changeValOf_internet(onChanged!);
                          initialized = false;
                          internet = false;
                          getModulesData(context);
                        }),
                    const Text("السيرفر")
                  ],
                ),
              ],
            );
          },
        ),
        Visibility(
            visible: currentuser!.email == "m.khaled",
            child: Item0(
              MediaQuery.of(context).size.width * .45,
              ColorManager.arsenic,
              " dashboard ",
              18,
              ontap: () {
                context.gonext(context, UsersDashboard());
              },
            )),
        Item0(
          MediaQuery.of(context).size.width * .45,
          ColorManager.arsenic,
          " users actions",
          17,
          ontap: () {
            context.gonext(context, const UsersActions());
          },
        ).permition(context, UserPermition.show_users_actions),
      ],
    ));
  }
}

class CustonSwitch extends StatelessWidget {
  const CustonSwitch({
    super.key,
    this.fontsize = 16,
  });
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "صرف البلوك اتوماتيك عند الاضافه للمخزن",
              style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}

class CustonSwitch2 extends StatelessWidget {
  CustonSwitch2({
    super.key,
    this.fontsize = 13,
  });
  final double fontsize;
  blocksStockViewModel vm = blocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    "الاضافه الاوتماتيكيه عند الضغط ",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "على الاختصار فى رصيد البلوك",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

showmyAlertDialog1(
    BuildContext context, SettingController myType, blocksStockViewModel vm) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const Text("ادخل رقم البدايه"),
              CustomTextFormField(hint: "", width: 100, controller: vm.N)
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('الغاء')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'تم',
                )),
          ],
        );
      });
}
