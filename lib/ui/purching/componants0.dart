// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/ui/purching/purchesController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/purching/Purches_veiwModel.dart';

class singnuturePad extends StatelessWidget {
  singnuturePad({
    super.key,
  });

  final keysingaturepad = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(border: Border.all(width: 3), color: Colors.white),
          child: SfSignaturePad(
            strokeColor: Colors.black,
            minimumStrokeWidth: 10,
            key: keysingaturepad,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              keysingaturepad.currentState!.clear();
            },
            child: const Text("clear")),
        ElevatedButton(
            onPressed: () async {
              // keysingaturepad.currentState
              //     ?.toImage()
              //     .then(
              //         (value) => value.toByteData(format: ImageByteFormat.png))
              //     .then((value) => value!.buffer.asUint8List())
              //     .then((value) => generate(value))
              //     .then((value) => context.gonext(
              //         context,
              //         PDfpreview(
              //           v: value.save(),
              //         )));
            },
            child: const Text("Done"))
      ],
    );
  }
}

class NewPurch extends StatelessWidget {
  NewPurch({super.key});
  PurchesViewMolel vm = PurchesViewMolel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<PurchesController>(
          builder: (context, myType, child) {
            return Form(
              key: vm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  errmsg(context),
                  const Center(
                    child: Text(
                      "تسجيل طلب شراء جديد",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .30,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) {
                              vm.administrationRequstTheOrder.text = value;
                            },
                            validator: Validation.validateOOOOOO,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          ":الاداره الطالبه",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .30,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) {
                              vm.purcheOrderRequester.text = value;
                            },
                            validator: Validation.validateOOOOOO,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          "اسم الطالب",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Header(),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: vm.permanentWidget
                          .map((e) => Center(
                                child: IntrinsicHeight(
                                    child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .10,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: const Center(
                                        child: Text(
                                          "م",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .12,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.quantity = value.to_double();
                                          },
                                          keyboardType: TextInputType.number,
                                          validator: Validation.validateOOOOOO,
                                          initialValue: "",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .20,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.Unit = value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                          initialValue: e.Unit.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .33,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.item = value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                          initialValue: e.item.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.note = value;
                                          },
                                          initialValue: e.note.toString(),
                                        ),
                                      ),
                                    ),
                                  ].reversed.toList(),
                                )),
                              ))
                          .toList(),
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (vm.formKey.currentState!.validate()) {
                              vm.permanentWidget.add(PurcheItem(
                                  item_Id:
                                      DateTime.now().microsecondsSinceEpoch,
                                  purcheOrder_Id: 0,
                                  quantity: 0,
                                  Unit: "",
                                  item: "",
                                  note: "",
                                  receiver: "",
                                  lastPrice: 0.0,
                                  offers: [],
                                  actions: []));
                              myType.Refrech_UI();
                            }
                          },
                          icon: const Icon(
                            size: 40,
                            Icons.add,
                            color: Colors.red,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            vm.addnewPurcheItem(context);
                            myType.Refrech_UI();
                          },
                          child: const Text('تسجيل'))
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class Header extends StatelessWidget {
  Header({
    super.key,
  });

  TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
          child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .10,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text(
                "م",
                style: style,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .12,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الكميه", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .20,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الوحده", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .33,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الصنف", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .25,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("ملاحظات", style: style),
            ),
          ),
        ].reversed.toList(),
      )),
    );
  }
}

class Details extends StatelessWidget {
  Details({
    super.key,
    required this.serial,
  });
  final int serial;
  TextEditingController supplyer = TextEditingController();
  TextEditingController price = TextEditingController();
  TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PurchesController>(
        builder: (context, myType, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ...myType.purchesOrders
                    .firstWhere((element) => element.serial == serial)
                    .items
                    .map((r) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            errmsg(context),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .10,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: const Color.fromARGB(
                                            255, 39, 240, 106)),
                                    child: Center(
                                      child: Text(
                                        "م",
                                        style: style,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .12,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: const Color.fromARGB(
                                            255, 39, 240, 106)),
                                    child: Center(
                                      child: Text("الكميه", style: style),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .16,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: const Color.fromARGB(
                                            255, 39, 240, 106)),
                                    child: Center(
                                      child: Text("الوحده", style: style),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .29,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: const Color.fromARGB(
                                            255, 39, 240, 106)),
                                    child: Center(
                                      child: Text("الصنف", style: style),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .21,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: const Color.fromARGB(
                                            255, 39, 240, 106)),
                                    child: Center(
                                      child: Text("ملاحظات", style: style),
                                    ),
                                  ),
                                ].reversed.toList(),
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .10,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                      child: Text(
                                        "${myType.purchesOrders.firstWhere((element) => element.serial == serial).items.indexOf(r) + 1}",
                                        style: style,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .12,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                      child: Text(r.quantity.toString(),
                                          style: style),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .16,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                      child: Text(r.Unit, style: style),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .29,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                      child: Text(r.item, style: style),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .21,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Center(
                                      child: Text(r.note, style: style),
                                    ),
                                  ),
                                ].reversed.toList(),
                              ),
                            ),

                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          content: SizedBox(
                                                            height: 110,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              7),
                                                                  child: CustomTextFormField(
                                                                      keybordtupe:
                                                                          TextInputType
                                                                              .name,
                                                                      hint:
                                                                          "المورد",
                                                                      width:
                                                                          130,
                                                                      controller:
                                                                          supplyer),
                                                                ),
                                                                CustomTextFormField(
                                                                    hint:
                                                                        "السعر للكميه",
                                                                    width: 120,
                                                                    controller:
                                                                        price),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  if (price.text
                                                                          .isNotEmpty &&
                                                                      supplyer
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    context.read<PurchesController>().Add_purche_item_offer(
                                                                        r,
                                                                        PurcheItemOffers(
                                                                            PurcheItemOffers_Id:
                                                                                DateTime.now().millisecondsSinceEpoch,
                                                                            item_Id: r.item_Id,
                                                                            purcheOrder_Id: r.purcheOrder_Id,
                                                                            syplyer: supplyer.text,
                                                                            price: price.text.to_double(),
                                                                            actions: []));
                                                                    price
                                                                        .clear();
                                                                    supplyer
                                                                        .clear();
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "تم"))
                                                          ],
                                                        ));
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.deepOrange,
                                          ))
                                      .permition(
                                          context,
                                          UserPermition
                                              .can_put_offer_in_purche),
                                  Text(
                                    "عروض الاسعار",
                                    style: style,
                                  ),
                                ],
                              ),
                            ),
                            //المورد و السعر و الاختيار
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .88,
                              child: Column(
                                children: [
                                  Table(
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 202, 201, 201)),
                                          children: [
                                            Center(
                                              child: Text(
                                                "المورد",
                                                style: style,
                                              ),
                                            ),
                                            Center(
                                                child: Text("السعر للكميه",
                                                    style: style)),
                                            Center(
                                                child: Text(" اختيار",
                                                    style: style)),
                                          ].reversed.toList())
                                    ],
                                  ),
                                  Consumer<PurchesController>(
                                    builder: (context, myType, child) {
                                      return Table(
                                        border: TableBorder.all(),
                                        children: r.offers
                                            .map((o) => TableRow(
                                                decoration:
                                                    const BoxDecoration(),
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      o.syplyer,
                                                      style: style,
                                                    ),
                                                  ),
                                                  Center(
                                                      child: Text(
                                                          o.price.toString(),
                                                          style: style)),
                                                  Column(
                                                    children: [
                                                      Checkbox(
                                                          value: o.actions
                                                              .if_action_exist(
                                                                  PurcheAction
                                                                      .offer_chosen
                                                                      .getTitle),
                                                          onChanged: (value) {
                                                            if (permitionss(
                                                                context,
                                                                UserPermition
                                                                    .can_chose_from_offerPurches)) {
                                                              o.actions.if_action_exist(
                                                                      PurcheAction
                                                                          .offer_chosen
                                                                          .getTitle)
                                                                  ? context
                                                                      .read<
                                                                          PurchesController>()
                                                                      .remove_offer(
                                                                          o)
                                                                  : context
                                                                      .read<
                                                                          PurchesController>()
                                                                      .chose_offer(
                                                                          o);
                                                            }
                                                          }),
                                                      o.actions.if_action_exist(
                                                              PurcheAction
                                                                  .offer_chosen
                                                                  .getTitle)
                                                          ? Text(o.actions
                                                              .get_purche_Who_Of(
                                                                  PurcheAction
                                                                      .offer_chosen))
                                                          : const SizedBox()
                                                    ],
                                                  )
                                                ].reversed.toList()))
                                            .toList(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                // التوقيعات
                Padding(
                  padding: const EdgeInsets.only(top: 33),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Column(
                      //   children: [
                      //     const Text("مدير المصنع",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      //          myType.purchesOrders.firstWhere((element) => element.serial==serial).actions.if_action_exist(PurcheAction.Purche_approved_generalm.getTitle)? Text(myType.purchesOrders.firstWhere((element) => element.serial==serial).actions.get_purche_Who_Of(PurcheAction.Purche_approved_generalm))     :const SizedBox(),
                      //     IconButton(onPressed: (){
                      //   if (permitionss(context, UserPermition.can_approve_from_generalManager)) {
                      //       PurcheOrder p=   myType.purchesOrders.firstWhere((element) => element.serial==serial);
                      //     p .actions.if_action_exist(PurcheAction.Purche_approved_generalm.getTitle)?
                      //       DoNothingAction():myType.aprove_on_purchOrder_form_GeneralManager(p);
                      //   }
                      //     }, icon:
                      //     myType.purchesOrders.firstWhere((element) => element.serial==serial).actions.if_action_exist(PurcheAction.Purche_approved_generalm.getTitle)?

                      //     const Icon(size: 50,
                      //     Icons.check
                      //     ,color: Colors.green):
                      //     const Icon(size: 50,
                      //     Icons.close
                      //     ,color: Colors.red)

                      //     ),
                      //   ],
                      // ),

                      Column(
                        children: [
                          const Text(
                            " رئيس القطاع المالى والادارئ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          myType.purchesOrders
                                  .firstWhere(
                                      (element) => element.serial == serial)
                                  .actions
                                  .if_action_exist(PurcheAction
                                      .Purche_approved_Financem.getTitle)
                              ? Text(myType.purchesOrders
                                  .firstWhere(
                                      (element) => element.serial == serial)
                                  .actions
                                  .get_purche_Who_Of(
                                      PurcheAction.Purche_approved_Financem))
                              : const SizedBox(),
                          IconButton(
                              onPressed: () {
                                if (permitionss(
                                    context,
                                    UserPermition
                                        .can_approve_from_financeManager)) {
                                  PurcheOrder p = myType.purchesOrders
                                      .firstWhere((element) =>
                                          element.serial == serial);
                                  p.actions.if_action_exist(PurcheAction
                                          .Purche_approved_generalm.getTitle)
                                      ? DoNothingAction()
                                      : myType
                                          .aprove_on_purchOrder_form_finance(p);
                                }
                              },
                              icon: myType.purchesOrders
                                      .firstWhere(
                                          (element) => element.serial == serial)
                                      .actions
                                      .if_action_exist(PurcheAction
                                          .Purche_approved_Financem.getTitle)
                                  ? const Icon(
                                      size: 50,
                                      Icons.check,
                                      color: Colors.green)
                                  : const Icon(
                                      size: 50,
                                      Icons.close,
                                      color: Colors.red)),
                        ],
                      ),

                      Column(
                        children: [
                          const Text(
                            "مدير المشتريات",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          myType.purchesOrders
                                  .firstWhere(
                                      (element) => element.serial == serial)
                                  .actions
                                  .if_action_exist(PurcheAction
                                      .Purche_approved_PurcheM.getTitle)
                              ? Text(myType.purchesOrders
                                  .firstWhere(
                                      (element) => element.serial == serial)
                                  .actions
                                  .get_purche_Who_Of(
                                      PurcheAction.Purche_approved_PurcheM))
                              : const SizedBox(),
                          IconButton(
                              onPressed: () {
                                if (permitionss(
                                    context,
                                    UserPermition
                                        .can_approve_from_purchingManager)) {
                                  PurcheOrder p = myType.purchesOrders
                                      .firstWhere((element) =>
                                          element.serial == serial);
                                  p.actions.if_action_exist(PurcheAction
                                          .Purche_approved_PurcheM.getTitle)
                                      ? DoNothingAction()
                                      : myType
                                          .aprove_on_purchOrder_form_PurcheManager(
                                              p);
                                }
                              },
                              icon: myType.purchesOrders
                                      .firstWhere(
                                          (element) => element.serial == serial)
                                      .actions
                                      .if_action_exist(PurcheAction
                                          .Purche_approved_PurcheM.getTitle)
                                  ? const Icon(
                                      size: 50,
                                      Icons.check,
                                      color: Colors.green)
                                  : const Icon(
                                      size: 50,
                                      Icons.close,
                                      color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
