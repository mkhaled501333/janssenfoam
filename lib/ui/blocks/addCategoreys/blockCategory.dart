// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/IN/outofStock_viewmoder.dart';
import 'package:janssenfoam/ui/blocks/IN/widgets.dart';
import 'package:janssenfoam/ui/blocks/addCategoreys/CategorysController.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';

import 'package:provider/provider.dart';

class BlockCategoryView extends StatelessWidget {
  BlockCategoryView({super.key});

  blocksStockViewModel vm = blocksStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: vm.formKey,
        child: Column(
          children: [
            errmsg(context),
            const SizedBox(
              height: 12,
            ),
            const DropDdowenFor_blockCategory(),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFormField(
                  keybordtupe: TextInputType.name,
                  width: MediaQuery.of(context).size.width * .70,
                  hint: " البيان",
                  controller: vm.blockdesription,
                ),
                CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .30,
                  hint: "الكثافه",
                  controller: vm.densitycontroller,
                  validator: Validation.validateothers,
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .50,
                  hint: "اللون",
                  keybordtupe: TextInputType.text,
                  controller: vm.colercontroller,
                  validator: Validation.validateothers,
                ),
                CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .50,
                  hint: "النوع",
                  keybordtupe: TextInputType.name,
                  controller: vm.typecontroller,
                  validator: Validation.validateothers,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (vm.formKey.currentState!.validate()) {
                    context
                        .read<Category_controller>()
                        .updateBlockCategory(
                            BlockCategory(
                                updatedat:
                                    DateTime.now().microsecondsSinceEpoch,
                                blockCategory_ID:
                                    DateTime.now().microsecondsSinceEpoch,
                                description: vm.blockdesription.text,
                                type: vm.typecontroller.text,
                                density: vm.densitycontroller.text,
                                color: vm.colercontroller.text,
                                actions: [
                              BlockCategoryAction.creat_new_block_category.add
                            ]));
                    vm.clearfields();
                  }
                },
                child: const SizedBox(
                  width: 90,
                  height: 45,
                  child: Center(
                    child: Text(
                      "اضافة",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
