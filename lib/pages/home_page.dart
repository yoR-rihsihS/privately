import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';
import 'package:privately/components/collapsing_drawer.dart';
import 'package:privately/models/chat_head_model.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final AuthImplementation auth;

  HomePage({this.onSignedOut, this.auth});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatHeadModel> chatHeadModel = [];

  void addChatHead()
  {
    setState(() {
      chatHeadModel.add(ChatHeadModel(name: "1234567891123456789212345", index: (chatHeadModel.length + 1)));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CollapsingDrawer(
        chatHeadModel: chatHeadModel,
        addChatHead: addChatHead,
      ),
      body: Container(
        color: Colors.pink,
        child: Center(
          child: FlatButton(
              onPressed: () {
                try {
                  widget.auth.signOutGoogle();
                  widget.onSignedOut();
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text('SignOut')),
        ),
      ),
    );
  }
}
