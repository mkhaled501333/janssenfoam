// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:provider/provider.dart';

class RDropDdowenFor_scissors_reports extends StatelessWidget {
  const RDropDdowenFor_scissors_reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        return Column(
          children: [
            const Text("المقص"),
            DropdownButton(
                value: Mytype.initioalFor_RScissorsReports,
                items: Mytype.scissorsRReports
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Mytype.get_RlabelReports(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initioalFor_RScissorsReports = v;
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
