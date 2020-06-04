import 'package:flutter/material.dart';
import 'package:privately/authentication.dart';
import 'package:privately/components/add_chartroom.dart';
import 'package:privately/components/collapsing_drawer.dart';
import 'package:privately/models/chat_head_model.dart';
import 'package:intl/intl.dart';
import 'package:privately/pages/chat_room.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final AuthImplementation auth;

  HomePage({this.onSignedOut, this.auth});

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatHeadModel> chatHeadModel = [];
  int currentSelectedIndex = 0;
  String _name;
  var format = DateFormat("H-m-d-M-y");

  void getName(String name) {
    _name = name;
  }

  void createChatRoom() {
    var now = format.format(DateTime.now());
    print(_name.replaceAll(" ", "") + "-" + now);
    setState(() {
      chatHeadModel.add(ChatHeadModel(
        name: _name,
        chatId: (_name + "-" + now),
      ));
      currentSelectedIndex = chatHeadModel.length;
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void addChatHead(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AddChatRoom(
          putName: getName,
          createChatRoom: createChatRoom,
        );
      },
    );
  }

  void changePage(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CollapsingDrawer(
        chatHeadModel: chatHeadModel,
        addChatHead: addChatHead,
        changePage: changePage,
        currentSelectedIndex: currentSelectedIndex,
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
              child: Text('SignOut $currentSelectedIndex')),
        ),
      ),
      // body: ChatRoom(),
    );
  }
}
