import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoftcaretask/Authentication/ViewModel/authviewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authviewmodel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back! SignIn',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              // style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateColor.transparent),
              onPressed: () {
                authviewmodel.loginn(
                  email: emailcontroller.text,
                  paswword: passwordcontroller.text,
                  context: context,
                );
              },
              child: const Text('Submit'),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot? Password',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
