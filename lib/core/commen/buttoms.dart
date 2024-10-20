// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton1 extends StatelessWidget {
  const MyButton1({
    super.key,
    required this.onpress,
    required this.tittle,
  });
  final void Function()? onpress;
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onpress,
        child: Container(
          width: 66,
          decoration: const BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.all(Radius.circular(11))),
          child: Center(
              child: Text(
            tittle,
            style: const TextStyle(
                fontSize: 24, color: Colors.amber, fontWeight: FontWeight.bold),
          )),
        ));
  }
}
