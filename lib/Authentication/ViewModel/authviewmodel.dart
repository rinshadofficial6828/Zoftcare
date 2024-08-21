import 'package:flutter/material.dart';
import 'package:zoftcaretask/Authentication/Repositery/authrepo.dart';
import 'package:zoftcaretask/PostList/View/postlistview.dart';
import 'package:zoftcaretask/SharedPrefrence/hive.dart';

class AuthViewModel extends ChangeNotifier {
  AuthRepo authRepo = AuthRepo();
  Future loginn(
      {required String email,
      required String paswword,
      required BuildContext context}) async {
    await authRepo.login(email: email, password: paswword).then(
      (value) {
        if (value?.status == true) {
          storetoken(value?.data?.accessToken ?? '');
          print('Login succeful');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Postlistview(),
              ));
        } else {
          print('login error');
        }
      },
    );
    notifyListeners();
  }
}
