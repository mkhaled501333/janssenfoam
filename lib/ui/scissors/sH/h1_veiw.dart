// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/chips/constans_view.dart';
import 'package:janssenfoam/core/recources/color_manager.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/scissors/sH/Widgets.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/scissors/sH/H1_veiwModel.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';

// ignore: must_be_immutable
class H1Veiw extends StatefulWidget {
  const H1Veiw({super.key, required this.scissor});

  final int scissor;
  @override
  State<H1Veiw> createState() => _H1VeiwState();
}

class _H1VeiwState extends State<H1Veiw> {
  H1VeiwModel vm = H1VeiwModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.permanentFractons.clear;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, b, child) {
        return Form(
          key: vm.formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.gonext(
                            context,
                            ReportwForHView(
                              scissor: widget.scissor,
                            ));
                      },
                      child: const Text(
                        " تقرير ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.grey),
                    child: Text(
                      "      مقص راسى ( ${widget.scissor} )     ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        diolg_ForSettingIN_mainveiwOF_H(context);
                      },
                      icon: const Icon(Icons.settings))
                ],
              ),
              const SearchForBlockIN_H(),
              NewVeiw(Hscissor: widget.scissor)
            ],
          ),
        );
      },
    );
  }
}

class Results extends StatelessWidget {
  const Results({
    super.key,
    required this.vm,
  });

  final H1VeiwModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Consumer<ObjectBoxController>(
        builder: (context, fractions, child) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: vm.permanentFractons
                      .map(
                        (e) => Container(
                            margin:
                                const EdgeInsets.only(bottom: 12, right: 12),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: ColorManager.gray,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorManager.blueGrey, width: 3)),
                            child: Text(
                              "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                      )
                      .toList(),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}

class Chips extends StatelessWidget {
  const Chips({
    super.key,
    required this.vm,
    required this.b,
    required this.scissor,
  });
  final H1VeiwModel vm;
  final List<BlockModel> b;
  final int scissor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      width: 150,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 9,
                children: []
                    .map((e) => InkWell(
                          onLongPress: () {},
                          onTap: () {
                            vm.addpermanentFractons(context, b, scissor, e);
                            context.read<ObjectBoxController>().get();
                            vm.clearfields();
                          },
                          child: Chip(
                              labelStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              label: Text(
                                  "  ${e.hight.removeTrailingZeros.toString()}* ${e.width.removeTrailingZeros.toString()}* ${e.lenth.removeTrailingZeros.toString()}")),
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class buttoms extends StatelessWidget {
  const buttoms({
    super.key,
    required this.b,
    required this.vm,
    required this.scissor,
  });
  final List<BlockModel> b;
  final int scissor;
  final H1VeiwModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                " قص",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
        ChipsForH123(),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              context.gonext(
                  context,
                  ReportwForHView(
                    scissor: scissor,
                  ));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                " تقرير ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}

class fields extends StatelessWidget {
  const fields({
    super.key,
    required this.b,
    required this.vm,
  });
  final List<BlockModel> b;
  final H1VeiwModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const DropDdowen002(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 18),
            child: CustomTextFormField(
                hint: " وزن دون التام",
                width: 120,
                validator: Validation.validateothers,
                controller: vm.wightcontroller),
          ),
          Column(
            children: [
              DropDdowenFor_blockColor123(b: b),
              const DropDdowen_forCode123(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: CustomTextFormField(
                    autovalidate: true,
                    hint: "رقم البلوك ",
                    width: 90,
                    validator: vm.validate_if_ExistforH(b, context),
                    controller: vm.numbercontroller),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDdowenFor_blockColor123 extends StatelessWidget {
  const DropDdowenFor_blockColor123({super.key, required this.b});
  final List<BlockModel> b;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        myType.getblocksConsumedAndNotCutted(context);

        return DropdownButton(
            value: context.read<ObjectBoxController>().initialcolorforH,
            items: myType
                .filtercolorforH(context
                    .read<BlockFirebasecontroller>()
                    .blocks
                    .values
                    .toList())
                .map((e) => e)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                myType.getblocksConsumedAndNotCutted(context);
                context.read<ObjectBoxController>().initialcolorforH = v;
                myType.serialforH = null;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class DropDdowen_forCode123 extends StatelessWidget {
  const DropDdowen_forCode123({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, mytype, child) {
        mytype.getblocksConsumedAndNotCutted(context);
        return DropdownButton(
            value: context.read<ObjectBoxController>().serialforH,
            items: mytype.blocksforH
                .filterserials()
                .map((e) => e.serial)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                mytype.getblocks(context);
                context.read<ObjectBoxController>().serialforH = v;
                mytype.getblocks(context);
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class DropDdowen002 extends StatelessWidget {
  const DropDdowen002({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        return DropdownButton(
            value: context.read<ObjectBoxController>().initial,
            items: v.notfials
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().initial = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}
