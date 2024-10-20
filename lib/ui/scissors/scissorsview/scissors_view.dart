import 'package:flutter/material.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import '../../../app/extentions.dart';
import '../scissors_controller.dart';
import '../sA/automaticScissor.dart';
import '../sH/h1_veiw.dart';
import '../sR/Rscissor_view.dart';
import 'package:provider/provider.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

// ignore: must_be_immutable
class ScissorsView extends StatelessWidget {
  const ScissorsView({super.key});
  @override
  Widget build(BuildContext context) {
    List csissorsPages = [
      const H1Veiw(
        scissor: 1,
      ).permition(context, UserPermition.show_H1),
      const H1Veiw(
        scissor: 2,
      ).permition(context, UserPermition.show_H2),
      const H1Veiw(
        scissor: 3,
      ).permition(context, UserPermition.show_H3),
      RVeiw2(Rscissor: 1).permition(context, UserPermition.show_R1),
      RVeiw2(Rscissor: 2).permition(context, UserPermition.show_R2),
      RVeiw2(Rscissor: 3).permition(context, UserPermition.show_R3),
      RVeiw23(
        Ascissor: 1,
      ).permition(context, UserPermition.show_R3),
    ];

    return Consumer<ScissorsController>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              errmsg(context),
              const Radiobuttom(),
              Expanded(
                child: csissorsPages[myType.indexOfRadioButon],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Radiobuttom extends StatelessWidget {
  const Radiobuttom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      width: 60,
      defaultSelected: Provider.of<ScissorsController>(context, listen: false)
          .indexOfRadioButon,
      elevation: 0,
      absoluteZeroSpacing: true,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: const ['H1', 'H2', 'H3', 'R1', 'R2', 'R3', 'A1'],
      // ignore: prefer_const_literals_to_create_immutables
      buttonValues: [0, 1, 2, 3, 4, 5, 6],
      radioButtonValue: (value) =>
          Provider.of<ScissorsController>(context, listen: false)
              .changeIndexOfRadioButoon(value),
      selectedColor: const Color.fromARGB(255, 127, 242, 40),
      buttonTextStyle: const ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          textStyle: TextStyle(fontSize: 16)),
    );
  }
}
