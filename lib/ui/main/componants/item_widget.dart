// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/color_manager.dart';

// ignore: must_be_immutable
class Item0 extends StatelessWidget {
  Item0(
    this.width,
    this.color,
    this.titele,
    this.number, {
    this.ontap,
    super.key,
  });
  void Function()? ontap;
  double width;
  final Color color;
  final String titele;
  final int number;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(top: 6),
        width: MediaQuery.of(context).size.width * .42,
        height: 80,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "$number",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                titele,
                style: TextStyle(
                    color: ColorManager.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
