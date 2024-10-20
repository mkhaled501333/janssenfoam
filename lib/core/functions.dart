// ignore_for_file: empty_catches

import 'package:http/http.dart' as http;
import 'package:janssenfoam/core/recources/publicVariables.dart';

bool isserveronline = false;
Stream<bool> isServerOnlineStream() async* {
  while (internet == false) {
    await Future.delayed(const Duration(seconds: 1));
    Uri uri = Uri.http('$ip:8080', '/test');
    try {
      var response = await http.get(uri);
      print(response.statusCode);
      yield response.statusCode == 200;
      isserveronline = response.statusCode == 200;
    } catch (e) {
      yield false;
      isserveronline = false;
    }
  }
}

Future<bool> isServerOnlinefuture() async {
  bool v = false;
  Uri uri = Uri.http(
    '$ip:8080',
  );
  try {
    var response = await http.get(uri);
    response.statusCode == 200 ? v = true : v = false;
  } catch (e) {}
  return v;
}
