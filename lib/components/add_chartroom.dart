import 'package:flutter/material.dart';

class AddChatRoom extends StatelessWidget {
  final Function(String) putName;
  final VoidCallback createChatRoom;

  AddChatRoom({
    this.putName,
    this.createChatRoom,
  });

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.tealAccent,
      title: Text("Add Chatroom"),
      contentPadding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      actionsPadding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      content: TextField(
        maxLength: 25,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Enter Chatroom Name here!",
        ),
        onChanged: (String value) {
          putName(value);
        },
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          onPressed: () {
            createChatRoom();
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
