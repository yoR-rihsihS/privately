import 'package:flutter/material.dart';

class ChatHead extends StatefulWidget {
  final String name;
  final Color color;
  final AnimationController animationController;
  final double maxWidth;
  final double minWidth;
  final VoidCallback onTap;

  ChatHead({
    this.name,
    this.color,
    this.animationController,
    this.minWidth,
    this.maxWidth,
    this.onTap,
  });

  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHead> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: widget.maxWidth, end: widget.minWidth)
        .animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8.0,
        left: 8.0,
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 22.0,
              backgroundColor: widget.color,
            ),
            SizedBox(
              width: 6.0,
            ),
            widthAnimation.value >= 80
                ? Expanded(
                    child: Text(
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : SizedBox(
                    width: 0.0,
                  ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
          ],
        ),
      ),
    );
  }
}
