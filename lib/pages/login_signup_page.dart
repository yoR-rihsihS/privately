import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';
import 'package:privately/components/login_signup.dart';

class LoginSignupPage extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  LoginSignupPage({this.auth, this.onSignedIn});

  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {

  Widget build(BuildContext context) {

    return Container(
      color: Colors.blueAccent,
      child: Stack(
        children: [
          LoginSignup(
            auth: widget.auth,
            onSignedIn: widget.onSignedIn,
          ),
        ],
      ),
    );
  }
}
