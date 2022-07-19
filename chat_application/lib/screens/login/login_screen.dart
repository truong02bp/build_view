import 'package:chat_application/screens/login/components/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          constraints: BoxConstraints.expand(height: 350),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/rectangle.png"),
                fit: BoxFit.cover),
          ),
        ),
        Body()
      ]),
    );
  }
}
