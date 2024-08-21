import 'package:dio/dio.dart';
import 'package:zoftcaretask/PostList/Model/postlistmodel.dart';

class Postrepo {
  // AuthResponseModel authResponseModel = AuthResponseModel();
  Future<PostList?> getposts({required String token, required int page}) async {
    try {
      var headers = {
        'x-auth-key': token,
      };
      var dio = Dio();

      print('Headers: $headers');

      var response = await dio.get(
        'https://mock-api.zoft.care/posts',
        queryParameters: {
          'page': page,
          'size': 10,
        },
        options: Options(
          headers: headers,
        ),
      );
      print('this is page number$page');
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return PostList.fromJson(response.data);
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('this is your error: $e');
    }
    return null;
  }
}
