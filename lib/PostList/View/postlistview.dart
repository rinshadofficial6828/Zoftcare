import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoftcaretask/Authentication/View/Login.dart';
import 'package:zoftcaretask/PostList/ViewModel/postviewmodel.dart';
import 'package:zoftcaretask/SharedPrefrence/hive.dart';

class Postlistview extends StatefulWidget {
  const Postlistview({super.key});

  @override
  State<Postlistview> createState() => _PostlistviewState();
}

class _PostlistviewState extends State<Postlistview> {
  late Timer _timer;
  int _start = 58;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
          removeToken(context);
          showDDialog();
        }
      });
    });
  }

  @override
  void dispose() {
    final postViewmodel = Provider.of<Postviewmodel>(context, listen: false);
    postViewmodel.scrollController.removeListener(postViewmodel.scrollListener);
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    final postViewmodel = Provider.of<Postviewmodel>(context, listen: false);
    postViewmodel.viewPost();
    postViewmodel.currentpage = 1;
    postViewmodel.scrollController.addListener(postViewmodel.scrollListener);
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postViewmodel = Provider.of<Postviewmodel>(context);

    if (postViewmodel.postList == null ||
        postViewmodel.postList?.data == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Posts'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        title: const Text(
          'Posts',
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: postViewmodel.scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12)),
                height: 25,
                width: 300,
                child: Text(
                  _start > 0
                      ? 'The Session will end in $_start seconds '
                      : 'Time is up! Please try again.',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postViewmodel.postList?.data?.length,
                itemBuilder: (context, index) {
                  final post = postViewmodel.postList?.data?[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              post?.image ?? 'https://via.placeholder.com/150',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post?.title ?? 'No Title',
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            post?.body ?? 'No Description',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 102, 102, 102)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Your Session has been Expired',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Text('OK'))
          ],
        );
      },
    );
  }
}
