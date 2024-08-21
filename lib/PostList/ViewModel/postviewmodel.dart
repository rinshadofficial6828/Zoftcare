import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoftcaretask/PostList/Model/postlistmodel.dart';
import 'package:zoftcaretask/PostList/Repositery/repositery.dart';

class Postviewmodel extends ChangeNotifier {
  Postrepo postrepo = Postrepo();
  PostList? postList;
  ScrollController scrollController = ScrollController();
  int currentpage = 1;
  bool isLoading = false;

  Future<void> viewPost() async {
    if (isLoading) return;

    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    print('Token from  $token');
    if (token == null || token.isEmpty) {
      print('Error: Token is null or empty');
      // Navigator.pushReplacementNamed(context, '/login');
      isLoading = false;
      return;
    }
    await postrepo.getposts(token: token, page: currentpage).then(
      (value) {
        if (value?.status == true) {
          if (postList == null) {
            postList = value;
          } else {
            postList?.data?.addAll(value!.data!);
          }
        } else {
          print('Error: Failed to retrieve posts');
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      currentpage++;
      viewPost();
      notifyListeners();
    }
  }
}

Future getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');
  return token != null;
}
