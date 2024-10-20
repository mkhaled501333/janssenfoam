// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalsController.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalStock_viewModel.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:provider/provider.dart';
import 'package:tabbed_view/tabbed_view.dart';

//صفحة تكويد اصناف جديده
class CreateChemicalCategory extends StatelessWidget {
  CreateChemicalCategory({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  late TabbedViewController _controller;
  List<TabData> tabs = [
    TabData(
        closable: false,
        text: '      العملاء      ',
        leading: (context, status) => const Icon(Icons.star, size: 5),
        content: Customers()),
    TabData(
        closable: false,
        text: '     الموردين       ',
        leading: (context, status) => const Icon(Icons.star, size: 5),
        content: Syplyers()),
    TabData(
        closable: false,
        text: '      الوحدات      ',
        leading: (context, status) => const Icon(Icons.star, size: 5),
        content: Units()),
    TabData(
        closable: false,
        text: '      العائلات      ',
        leading: (context, status) => const Icon(Icons.star, size: 5),
        content: Familyes()),
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    _controller = TabbedViewController(tabs);
    TabbedView tabbedView = TabbedView(
      controller: _controller,
      onTabSelection: (newindex) {
        index = newindex!;
      },
    );
    Widget w =
        TabbedViewTheme(data: TabbedViewThemeData.mobile(), child: tabbedView);
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("تكويد اصناف جديده"),
          ),
          body: Form(
            key: vm.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  errmsg(context),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: w,
                    ),
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Familyes extends StatelessWidget {
  Familyes({
    super.key,
  });

  ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        var d = myType.chemicalsCategorys;
        return SizedBox(
            width: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(13),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('اضافة عائله جديده'),
                                content: SizedBox(
                                  width: 100,
                                  height: 130,
                                  child: Column(children: [
                                    Column(
                                      children: [
                                        CustomTextFormField(
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return 'فارغ';
                                              } else {
                                                return null;
                                              }
                                            },
                                            keybordtupe: TextInputType.name,
                                            hint: "عائله جديده",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .28,
                                            controller: vm.family),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (vm.family.text != '') {
                                                vm.addFamily(context);
                                              }
                                            },
                                            child: const Text("Add")),
                                      ],
                                    ),
                                  ]),
                                ),
                              );
                            });
                      },
                      child: const Text("اضافة عائله جديده")),
                  const Gap(13),
                  ...d
                      .map((element) => element.family)
                      .toSet()
                      .toList()
                      .map((e) => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 0.4,
                              ),
                            ),
                            child: ExpansionTile(
                                collapsedBackgroundColor:
                                    const Color.fromARGB(255, 233, 185, 42),
                                backgroundColor:
                                    const Color.fromARGB(255, 232, 239, 134),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      e,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text('$e اضافة صنف فى '),
                                                  content: SizedBox(
                                                    width: 100,
                                                    height: 130,
                                                    child: Column(children: [
                                                      Column(
                                                        children: [
                                                          CustomTextFormField(
                                                              validator: (v) {
                                                                if (v!
                                                                    .isEmpty) {
                                                                  return 'فارغ';
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              keybordtupe:
                                                                  TextInputType
                                                                      .name,
                                                              hint: "اسم الصنف",
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .28,
                                                              controller:
                                                                  vm.item),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                if (vm.item
                                                                        .text !=
                                                                    "") {
                                                                  vm.addItme(
                                                                      context,
                                                                      e);
                                                                }
                                                              },
                                                              child: const Text(
                                                                  "Add")),
                                                        ],
                                                      ),
                                                    ]),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.add))
                                  ],
                                ),
                                leading: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                width: 100,
                                                height: 130,
                                                child: Column(children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        vm.deleteFamily(
                                                            context, e);
                                                      },
                                                      child: const Text("تم")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("الغاء")),
                                                ]),
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.delete)),
                                children: [
                                  Wrap(
                                      spacing: 5,
                                      children: d
                                          .where((test) => test.family == e)
                                          .map((e) => ElevatedButton(
                                              onPressed: () {},
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.green)),
                                              onLongPress: () {
                                                vm.deleteItem(context, e);
                                              },
                                              child: Text(e.item,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))))
                                          .toList()),
                                ]),
                          )),
                  const Gap(150),
                ],
              ),
            ));
      },
    );
  }
}

class Units extends StatelessWidget {
  Units({
    super.key,
  });

  final ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return SizedBox(
          width: 200,
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('اضافة وحده جديده'),
                            content: SizedBox(
                              height: 300,
                              child: Column(children: [
                                Column(
                                  children: [
                                    CustomTextFormField(
                                        keybordtupe: TextInputType.name,
                                        hint: "وحدة جديده",
                                        width: 130,
                                        controller: vm.unit),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextFormField(
                                        hint: "الكميه للوحده",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .28,
                                        controller: vm.quantityForUnit),
                                    ElevatedButton(
                                        onPressed: () {
                                          vm.addUnit(context);
                                        },
                                        child: const Text("Add")),
                                  ],
                                ),
                              ]),
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('ok')),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.add)),
              ...myType.units.map((e) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: const Color.fromARGB(255, 214, 213, 209),
                        borderRadius: BorderRadius.circular(9)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(e.quantity.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Gap(22),
                        IconButton(
                            onPressed: () {
                              vm.deleteUnit(context, e);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )),
              const Gap(150),
            ],
          ),
        );
      },
    );
  }
}

class Customers extends StatelessWidget {
  Customers({
    super.key,
  });

  final ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return SizedBox(
          width: 200,
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('اضافة عميل جديد'),
                            content: SizedBox(
                              height: 300,
                              child: Column(children: [
                                Column(
                                  children: [
                                    CustomTextFormField(
                                        hint: "اسم العميل",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .28,
                                        controller: vm.customer),
                                    ElevatedButton(
                                        onPressed: () {
                                          vm.addcustomer(context);
                                        },
                                        child: const Text("Add")),
                                  ],
                                ),
                              ]),
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('ok')),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.add)),
              ...myType.chemicalcusomers.map((e) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: const Color.fromARGB(255, 214, 213, 209),
                        borderRadius: BorderRadius.circular(9)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(e.name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Gap(22),
                        IconButton(
                            onPressed: () {
                              vm.deleteCustomer(context, e);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )),
              const Gap(150),
            ],
          ),
        );
      },
    );
  }
}

class Syplyers extends StatelessWidget {
  Syplyers({
    super.key,
  });

  final ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return SizedBox(
          width: 200,
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('اضافة مورد جديد'),
                            content: SizedBox(
                              height: 300,
                              child: Column(children: [
                                Column(
                                  children: [
                                    CustomTextFormField(
                                        hint: "اسم المورد",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .28,
                                        controller: vm.supplyer),
                                    ElevatedButton(
                                        onPressed: () {
                                          vm.addSupplyer(context);
                                        },
                                        child: const Text("Add")),
                                  ],
                                ),
                              ]),
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('ok')),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.add)),
              ...myType.chemicalsuplyers.map((e) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: const Color.fromARGB(255, 214, 213, 209),
                        borderRadius: BorderRadius.circular(9)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(e.name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Gap(22),
                        IconButton(
                            onPressed: () {
                              vm.deletesypler(context, e);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )),
              const Gap(150),
            ],
          ),
        );
      },
    );
  }
}
