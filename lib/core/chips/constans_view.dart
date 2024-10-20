// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/core/chips/constants_viewmoder.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';

class ChipsForblocks extends StatelessWidget {
  ChipsForblocks({super.key});
  ConstantsViewModel vm = ConstantsViewModel();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 600,
                      child: Form(
                        key: vm.formKey,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue[900],
                              height: 30,
                              child: const Center(
                                child: Text(
                                  'اضافة اختصار جديد ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "الكثافه",
                                      controller: vm.densitycontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "اللون",
                                      keybordtupe: TextInputType.text,
                                      controller: vm.colercontroller,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "الكود ",
                                      controller: vm.codecontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "الوزن ",
                                      controller: vm.wightcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "العرض",
                                      controller: vm.widthcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "الطول ",
                                      controller: vm.lenthcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "النوع",
                                      keybordtupe: TextInputType.name,
                                      controller: vm.typecontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "الارتفاع",
                                      controller: vm.hightncontroller,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "وارد من",
                                      keybordtupe: TextInputType.name,
                                      controller: vm.cummingFrom,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "ملاحظات",
                                      keybordtupe: TextInputType.name,
                                      controller: vm.notes,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "العنوان",
                                      keybordtupe: TextInputType.name,
                                      controller: vm.tiitlecontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .23,
                                      hint: "البيان",
                                      keybordtupe: TextInputType.name,
                                      controller: vm.blockdesription,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () {
                                        vm.addchipblock(context);
                                      },
                                      child: const Text('أضافه')),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('الغاء')),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        icon: const Icon(Icons.add));
  }
}

class ChipsForH123 extends StatelessWidget {
  ChipsForH123({super.key});
  ConstantsViewModel vm = ConstantsViewModel();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 200,
                      child: Form(
                        key: vm.formKey,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue[900],
                              height: 30,
                              child: const Center(
                                child: Text(
                                  ' عمل اختصار جديد ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .18,
                                      hint: "الارتفاع",
                                      controller: vm.hightncontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .18,
                                      hint: "العرض",
                                      controller: vm.widthcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .18,
                                      hint: "الطول ",
                                      controller: vm.lenthcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () {
                                        vm.addfractionchip(context);
                                      },
                                      child: const Text('أضافه')),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('الغاء')),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        icon: const Icon(Icons.add));
  }
}
