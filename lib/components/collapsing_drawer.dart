import 'package:flutter/material.dart';
import 'package:privately/components/chat_head.dart';
import 'package:privately/models/chat_head_model.dart';

class CollapsingDrawer extends StatefulWidget {
  final List<ChatHeadModel> chatHeadModel;
  final VoidCallback addChatHead;

  CollapsingDrawer({this.chatHeadModel, this.addChatHead});

  _CollapsingDrawerState createState() => _CollapsingDrawerState();
}

class _CollapsingDrawerState extends State<CollapsingDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  double minWidth = 60;
  double maxWidth = 240;
  AnimationController _animationController;
  Animation<double> widthAnimation;

  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widgett) => getWidget(context));
  }

  Widget getWidget(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      width: widthAnimation.value,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: 10.0,
              ),
              itemBuilder: (BuildContext context, int counter) {
                return ChatHead(
                  name: widget.chatHeadModel[counter].name,
                  index: widget.chatHeadModel[counter].index,
                  animationController: _animationController,
                  minWidth: minWidth,
                  maxWidth: maxWidth,
                );
              },
              itemCount: widget.chatHeadModel == null
                  ? 0
                  : widget.chatHeadModel.length,
            ),
          ),
          InkWell(
            child: Icon(isCollapsed ? Icons.chevron_right : Icons.chevron_left),
            onTap: () {
              setState(() {
                isCollapsed = !isCollapsed;
                isCollapsed
                    ? _animationController.forward()
                    : _animationController.reverse();
              });
            },
          ),
          InkWell(
            child: Icon(Icons.add_circle_outline),
            onTap: () {
              setState(() {
                widget.addChatHead();
              });
            },
          ),
        ],
      ),
    );
  }
}
