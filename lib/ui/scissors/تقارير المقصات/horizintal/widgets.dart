// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:provider/provider.dart';

class DropDdowenFor_scissors_reports extends StatelessWidget {
  const DropDdowenFor_scissors_reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        return Column(
          children: [
            const Text("المقص"),
            DropdownButton(
                value: Mytype.initioalFor_ScissorsReports,
                items: Mytype.scissorsReports
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Mytype.get_labelReports(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initioalFor_ScissorsReports = v;
                    Mytype.Refrsh_ui();
                    context.read<BlockFirebasecontroller>().Refresh_the_UI();
                  }
                }),
          ],
        );
      },
    );
  }
}
