import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';
import 'package:privately/mapping.dart';

void main() {
  runApp(Privately());
}

class Privately extends StatelessWidget {
  final AuthImplementation auth = Auth();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mapping(
        auth: auth,
      ),
    );
  }
}
