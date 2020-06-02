import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';

class LoginSignup extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  LoginSignup({this.auth, this.onSignedIn});

  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: height / 2),
      color: Colors.transparent,
      child: FlatButton(
        onPressed: () async {
          try {
            await widget.auth.signInWithGoogle();
            widget.onSignedIn();
          } catch (e) {
            print(e.toString());
          }
        },
        child: Text("Get Started"),
      ),
    );
  }
}
