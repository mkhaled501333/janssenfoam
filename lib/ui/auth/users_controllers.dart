// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/core/recources/strings_manager.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

UserModel? currentuser;

class Users_controller extends ChangeNotifier with firebaseAuth {
  Uri uri = Uri.http('$ip:8080', '/users').replace().replace(queryParameters: {
    'username': Sharedprfs.getemail(),
    'password': Sharedprfs.getpassword()
  });
  Uri WSuri = Uri.parse('ws://$ip:8080/users/ws').replace(queryParameters: {
    'username': Sharedprfs.getemail(),
    'password': Sharedprfs.getpassword()
  });

  late WebSocketChannel channel;
  List<UserModel> users = [];

  getuser(String email, String password) {
    if (internet == true) {
      getuserFronFiresbase(email, password).then((onValue) {
        notifyListeners();
      });
    } else if (isserveronline == true) {
      usersFrom_server(email, password);
    }
  }

  usersFrom_server(String email, String password) {
    Uri uri = Uri.parse('ws://$ip:8080/users/ws')
        .replace(queryParameters: {'username': email, 'password': password});
    channel = WebSocketChannel.connect(uri);
    channel.sink.add('');
    channel.stream.forEach((u) {
      UserModel user = UserModel.fromJson(u);
      currentuser = user;
      SringsManager.myemail = user.name;
      Sharedprfs.setemail(user.email);
      Sharedprfs.setpassword(user.password);
      notifyListeners();
    });
  }

  getAllUsers() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/users');

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      users.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var user = UserModel.fromMap(element);
        if (user.actions.if_action_exist(UserAction.archive_user.getTitle) ==
            false) {
          users.add(user);
        }
      }
      notifyListeners();
    }
  }

  updateUser(UserModel user) async {
    Uri uri = Uri.http('$ip:8080', '/users');

    if (internet == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.user_Id.toString())
          .set(user.toMap());
    } else {
      await http.put(uri, body: user.toJson()).then((e) => getAllUsers());
    }
  }

  Refrsh_ui() {
    notifyListeners();
  }

  assignValOF_internet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('internet', false);
    internet = prefs.getBool('internet')!;
  }

  changeValOf_internet(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('internet', val);
    internet = val;
    notifyListeners();
  }
}

mixin firebaseAuth {
  addUserToFirestore(UserModel user) {
    print('add user');
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.user_Id.toString())
        .set(user.toMap());
  }

  Future<UserModel?> getuserFronFiresbase(String username, String password) {
    return FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: username)
        .where("password", isEqualTo: password)
        .get()
        .then((onValue) {
      currentuser = UserModel.fromMap(onValue.docs.first.data());
      SringsManager.myemail = currentuser!.name;
      print(UserModel.fromMap(onValue.docs.first.data()));
      return currentuser;
    });
  }
}
