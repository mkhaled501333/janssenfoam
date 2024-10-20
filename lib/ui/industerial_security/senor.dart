import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';
import 'package:provider/provider.dart';

class Sensor extends StatelessWidget {
  const Sensor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<IndusterialSecuritycontroller>(
        builder: (context, myType, child) {
          return Column(
            children: [
              Center(
                child: Text(myType.sensotdata!.date.formatt_hms()),
              ),
              Center(
                child: Text((1 + myType.sensotdata!.val).toString()),
              )
            ],
          );
        },
      ),
    );
  }
}
