import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  // bool isServerOnline = false;

  // streamServerStutues() {
  //   Timer.periodic(const Duration(seconds: 1), (t) async {
  //     if (ip == '') {
  //       NetworkDiscovery.discover('192.168.1', 8080).forEach((e) {
  //         if (ip != e.ip) {
  //           ip = e.ip;
  //           notifyListeners();
  //         }
  //         print('ffff ${e.ip}');
  //       });
  //     } else {
  //       try {
  //         Uri uri = Uri.http('$ip:8080', '/test');
  //         var response = await http.get(uri);
  //         if (response.statusCode != 200) {
  //           ip = '';
  //           isServerOnline = false;
  //           notifyListeners();
  //         } else {
  //           if (isServerOnline == false) {
  //             isServerOnline = true;
  //             notifyListeners();
  //           }
  //         }
  //       } catch (e) {
  //         if (isServerOnline != false && ip != '') {
  //           ip = '';
  //           isServerOnline = false;
  //           notifyListeners();
  //         }

  //         print(e);
  //       }
  //     }
  //   });
  // }

  int currentIndex = 2;

  changecurrenIndexogbuttonNav(val) {
    currentIndex = val;
    notifyListeners();
  }
}
