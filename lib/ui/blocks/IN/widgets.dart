// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/addCategoreys/CategorysController.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/setings/Setings.dart';

import 'package:provider/provider.dart';

class HeaderOftable1 extends StatelessWidget {
  const HeaderOftable1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(.8),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
        6: FlexColumnWidth(1),
        7: FlexColumnWidth(2.8),
        8: FlexColumnWidth(2.8),
        9: FlexColumnWidth(1),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text(' حذف'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('ملاحظات '))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الصرف'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الانشاء'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('صادر الى'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وارد من'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('م راسى')),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('البيان'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('رقم وكود')),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('م')),
            ])
      ],
    );
  }
}

class DropDdowenFor_blockCategory extends StatelessWidget {
  const DropDdowenFor_blockCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Category_controller>(
      builder: (context, myType, child) {
        return DropdownButton(
            value: myType.initialFordropdowen,
            items: myType.blockCategorys
                .map((e) => e)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.description.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<Category_controller>().initialFordropdowen = v;
                context.read<Category_controller>().Refresh_Ui();
              }
            });
      },
    );
  }
}

class CusotmRadio extends StatelessWidget {
  const CusotmRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'فردى ',
          ),
          leading: Radio(
            value: 1,
            groupValue: 1,
            activeColor: const Color(0xFF6200EE),
            onChanged: (c) {},
          ),
        ),
        ListTile(
          title: const Text(
            'من الى',
          ),
          leading: Radio(
            value: 1,
            groupValue: 2,
            activeColor: const Color(0xFF6200EE),
            onChanged: (c) {},
          ),
        ),
      ],
    );
  }
}

settingthedialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController c = TextEditingController();

        return Consumer<SettingController>(
          builder: (context, myType, child) {
            return AlertDialog(
              title: const Text(' setting ?'),
              content: SizedBox(
                height: 350,
                child: Column(children: [
                  Center(child: CustonSwitch2()),
                  const Divider(
                    height: 30,
                    thickness: 5,
                    color: Colors.black,
                  ),
                  Column(
                    children: [
                      const Text("طريقةالادراج"),
                      ListTile(
                        title: const Text(
                          'فردى ',
                        ),
                        leading: Radio(
                          value: 1,
                          groupValue: myType.GroupvalueofRadio,
                          activeColor: const Color(0xFF6200EE),
                          onChanged: (c) {
                            myType.GroupvalueofRadio = c!;
                            myType.Refresh_Ui();
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'من الى',
                        ),
                        leading: Radio(
                          value: 2,
                          groupValue: myType.GroupvalueofRadio,
                          activeColor: const Color(0xFF6200EE),
                          onChanged: (c) {
                            myType.GroupvalueofRadio = c!;
                            myType.Refresh_Ui();
                          },
                        ),
                      ),
                      const Divider(
                        height: 30,
                        thickness: 5,
                        color: Colors.black,
                      ),
                      Column(children: [
                        const Text("كميه العرض"),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            controller: c,
                          ),
                        )
                      ]),
                    ],
                  ),
                ]),
              ),
              actions: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      c.text.isNotEmpty
                          ? myType.amountofshowinaddBlock = c.text.to_int()
                          : DoNothingAction();
                      context.read<BlockFirebasecontroller>().Refresh_the_UI();

                      Navigator.pop(context);
                    },
                    child: const Text('تم')),
              ],
            );
          },
        );
      });
}

class SearchForBlockIN_Blcokstock extends StatelessWidget {
  const SearchForBlockIN_Blcokstock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Container(
        color: const Color.fromARGB(96, 230, 218, 218),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              icon: Icon(Icons.search), border: OutlineInputBorder()),
          onChanged: (v) {
            context.read<BlockFirebasecontroller>().searchin_blockstock = v;
            context.read<BlockFirebasecontroller>().Refresh_the_UI();
          },
        ),
      ),
    );
  }
}
