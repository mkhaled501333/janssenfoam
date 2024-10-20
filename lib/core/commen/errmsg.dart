import 'package:flutter/material.dart';
import 'package:janssenfoam/core/functions.dart';

int x = 0;
Widget errmsg(BuildContext context) {
  print('errorrmss');
  return StreamBuilder(
    stream: isServerOnlineStream(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Visibility(
          visible: snapshot.data != null && !snapshot.data,
          child: Container(
            padding: const EdgeInsets.all(10.00),
            margin: const EdgeInsets.only(bottom: 10.00),
            color: Colors.red,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: const EdgeInsets.only(right: 6.00),
                child: const Icon(Icons.info, color: Colors.white),
              ), // icon for error message

              const Center(
                  child: Text('لا يوجد اتصال ب السيرفر ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
              //show error message text
            ]),
          ));
    },
  );
}
