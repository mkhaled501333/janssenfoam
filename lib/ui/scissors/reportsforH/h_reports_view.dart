// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/scissors/reportsforH/Widgets.dart';

class HReprotsView extends StatelessWidget {
  HReprotsView({super.key});
  List<int> s = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(" يومية انتاج المقصات الراسى "),
      // ),
      body: SafeArea(
        child: Column(
          children: s
              .map(
                (e) => SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          errmsg(context),
                          Results(
                            scissor: e,
                            blocks: const [],
                          ),
                          SizedBox(
                              width: 500,
                              child: blockstockInventoryForH(
                                scissor: e,
                              )),
                        ],
                      )),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
