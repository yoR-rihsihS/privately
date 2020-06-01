import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';


class HomePage extends StatelessWidget {
  final VoidCallback onSignedOut;
  final AuthImplementation auth;

  HomePage({this.onSignedOut, this.auth});

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FlatButton(
          onPressed: ()
          {
            try {
              auth.signOutGoogle();
              onSignedOut();
            }
            catch (e)
            {
              print(e.toString());
            }
          },
          child: Text('SignOut')
        ),
      ),
    );
  }
}