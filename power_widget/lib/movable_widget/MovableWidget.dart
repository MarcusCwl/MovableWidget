library movable_widget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:power_widget/listener/WidgetEventListener.dart';
import 'package:power_widget/serializable/SerializableWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';

// ignore: must_be_immutable
class MovableWidget extends SerializableWidget {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final WidgetEventListener widgetEventListener;

  //Key of Widget which need to show and impl movable statement
  //We use this to get size of widget
  final GlobalKey widgetKey;

  //Widget which need to show and impl movable statement
  final Widget widget;

  MovableState movableState;

  MovableWidget(this.left, this.top, this.right, this.bottom, this.widget, this.widgetKey, this.widgetEventListener) {
    this.movableState = MovableState(left, top, right, bottom, widget, widgetKey, widgetEventListener);
  }

  @override
  State<StatefulWidget> createState() {
    return movableState;
  }

  @override
  WidgetSerializableModel getWidgetSerializableModel() {
    double left = movableState.left;
    double top = movableState.top;
    double width = movableState.getSize().width;
    double height = movableState.getSize().height;
    return WidgetSerializableModel(left, top, left + width, top + height);
  }
}

class MovableState extends State<MovableWidget> with SingleTickerProviderStateMixin {
  final double xMin;
  final double yMin;
  final double xMax;
  final double yMax;
  final GlobalKey widgetKey;
  final WidgetEventListener widgetEventListener;
  Widget child;

  double top;
  double left;

  MovableState(this.xMin, this.yMin, this.xMax, this.yMax, this.child, this.widgetKey, this.widgetEventListener) {
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
            onTap: () => widgetEventListener.onTap(),
            onPanEnd: (DragEndDetails e) {},
          ),
        )
      ],
    );
  }
}
