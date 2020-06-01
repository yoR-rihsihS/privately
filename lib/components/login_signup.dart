import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';

class LoginSignup extends StatelessWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  LoginSignup({this.auth, this.onSignedIn});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container (
      margin: EdgeInsets.only(top: height/2),
      color: Colors.transparent,
      child: FlatButton(
        onPressed: () async
        {
          try
          {
            await auth.signInWithGoogle();
            onSignedIn();
          }
          catch(e)
          {
            print(e.toString());
          }
        },
        child: Text("Get Started"),
      ),
    );
  }
}