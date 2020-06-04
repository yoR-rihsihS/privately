import 'package:flutter/material.dart';
import 'package:privately/components/chat_head.dart';
import 'package:privately/models/chat_head_model.dart';

class CollapsingDrawer extends StatefulWidget {
  final int currentSelectedIndex;
  final List<ChatHeadModel> chatHeadModel;
  final Function(BuildContext) addChatHead;
  final Function(int) changePage;

  CollapsingDrawer(
      {this.chatHeadModel,
      this.addChatHead,
      this.changePage,
      this.currentSelectedIndex});

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
          Container(
            height: 72.0,
            width: widthAnimation.value,
            color: Colors.deepOrange[500],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ChatHead(
                    name: "Name",
                    color: widget.currentSelectedIndex == 0
                        ? Colors.white
                        : Colors.black,
                    animationController: _animationController,
                    minWidth: minWidth,
                    maxWidth: maxWidth,
                    onTap: () {
                      widget.changePage(0);
                    },
                  ),
                ]),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: 10.0,
              ),
              itemBuilder: (BuildContext context, int counter) {
                return ChatHead(
                  name: widget.chatHeadModel[counter].name,
                  color: widget.currentSelectedIndex == (counter + 1)
                      ? Colors.white
                      : Colors.black,
                  animationController: _animationController,
                  minWidth: minWidth,
                  maxWidth: maxWidth,
                  onTap: () {
                    widget.changePage(counter + 1);
                  },
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
                widget.addChatHead(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
