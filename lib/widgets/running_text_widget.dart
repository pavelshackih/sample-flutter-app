import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class RunningTextWidget extends StatefulWidget {
  @override
  _RunningTextWidgetState createState() => _RunningTextWidgetState();
}

class _RunningTextWidgetState extends State<RunningTextWidget>
    with SingleTickerProviderStateMixin {
  final String _text = "".toUpperCase();
  AnimationController _animationController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    double offset = 0.0;
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..addListener(() {
            if (_animationController.isCompleted) {
              _animationController.repeat();
            }
            offset += 0.5;
            setState(() {
              _scrollController.jumpTo(offset);
            });
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Text(
              _text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            );
          }),
    );
  }
}
