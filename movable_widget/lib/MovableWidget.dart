library movable_widget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovableWidget extends StatefulWidget {
  final double top;
  final double left;
  final double right;
  final double bottom;

  //Key of Widget which need to show and impl movable statement
  //We use this to get size of widget
  final GlobalKey widgetKey;
  //Widget which need to show and impl movable statement
  final Widget widget;

  MovableWidget(this.left, this.top, this.right, this.bottom, this.widget,
      this.widgetKey);

  @override
  State<StatefulWidget> createState() {
    return MovableState(left, top, right, bottom, widget, widgetKey);
  }
}

class MovableState extends State<MovableWidget>
    with SingleTickerProviderStateMixin {
  final double xMin;
  final double yMin;
  final double xMax;
  final double yMax;
  final GlobalKey widgetKey;
  Widget child;

  double top;
  double left;

  MovableState(
      this.xMin, this.yMin, this.xMax, this.yMax, this.child, this.widgetKey) {
    top = this.yMin;
    left = this.xMin;
  }

  Size getSize() {
    final RenderBox renderBoxRed = widgetKey.currentContext.findRenderObject();
    return renderBoxRed.size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: GestureDetector(
            child: child,
            onPanUpdate: (DragUpdateDetails e) {
              setState(() {
                double tempLeft = left + e.delta.dx;
                double tempTop = top + e.delta.dy;
                if (tempLeft >= xMax - getSize().width) {
                  left = xMax - getSize().width;
                } else if (tempLeft <= xMin) {
                  left = xMin;
                } else {
                  left = tempLeft;
                }

                if (tempTop >= yMax - getSize().height) {
                  top = yMax - getSize().height;
                } else if (tempTop <= yMin) {
                  top = yMin;
                } else {
                  top = tempTop;
                }
              });
            },
            onPanEnd: (DragEndDetails e) {
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}
