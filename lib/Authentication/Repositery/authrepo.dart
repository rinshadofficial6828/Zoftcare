import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zoftcaretask/Authentication/Model/authresponse.dart';

class AuthRepo {
  Future<AuthResponseModel?> login({String? email, String? password}) async {
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {'email': email, 'password': password};
      var dio = Dio();
      var response = await dio.request(
        'https://mock-api.zoft.care/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return AuthResponseModel.fromJson(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("this is your error$e");
    }
  }
}
