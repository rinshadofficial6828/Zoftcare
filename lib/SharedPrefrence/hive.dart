import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoftcaretask/Authentication/View/Login.dart';
import 'package:zoftcaretask/PostList/View/postlistview.dart';

storetoken(String token) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('token', token);
}

void checkLogin(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');
  if (token != null) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Postlistview(),
        ));
  } else {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }
}

Future<void> removeToken(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}
