import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';
import 'package:privately/pages/home_page.dart';
import 'package:privately/pages/login_signup_page.dart';

class Mapping extends StatefulWidget {
  final AuthImplementation auth;

  Mapping({this.auth});

  _MappingState createState() => _MappingState();
}

enum AuthStatus
{
  signedIn,
  notSignedIn,
}


class _MappingState extends State<Mapping> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  void initState() { 
    super.initState();
    
    widget.auth.getCurrentUser().then((firebaseUserId)
    {
      setState(() {
        firebaseUserId == null ? _authStatus = AuthStatus.notSignedIn : _authStatus = AuthStatus.signedIn;
      });
    });
  }

  void _signedIn()
  {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut()
  {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
  
  Widget build(BuildContext context) {
    switch (_authStatus)
    {
      case AuthStatus.notSignedIn:
        return LoginSignupPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return Container();
  }
}