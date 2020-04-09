library movable_widget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:power_widget/listener/WidgetEventListener.dart';
import 'package:power_widget/serializable/SerializableStatefulWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';
import 'package:power_widget/widgets/PowerWidget.dart';

// ignore: must_be_immutable
class MovableWidgetModule extends SerializableStatefulWidget {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final List<PowerWidget> widgets;

  //Key of Widget which need to show and impl movable statement
  //We use this to get size of widget

  MovableWidgetModuleState state;

  MovableWidgetModule(this.left, this.top, this.right, this.bottom, this.widgets) {
    this.state = MovableWidgetModuleState(left, top, right, bottom, widgets);
  }

  void updateState() {
    if (state.mounted) {
      state.setState(() {});
    }
  }

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  @override
  WidgetSerializableModel getWidgetSerializableModel() {
    return null;
  }
}

class MovableWidgetModuleState extends State<MovableWidgetModule> with SingleTickerProviderStateMixin {
  final double xMin;
  final double yMin;
  final double xMax;
  final double yMax;
  final List<PowerWidget> widgets;

  MovableWidgetModuleState(this.xMin, this.yMin, this.xMax, this.yMax, this.widgets);

  Size getSize(PowerWidget widget) {
    final BuildContext context = widget.globalKey.currentContext;
    if (context != null) {
      final RenderBox renderBoxRed = widget.globalKey.currentContext.findRenderObject();
      return renderBoxRed.size;
    } else {
      return Size.zero;
    }
  }

  List<Positioned> getWidgetsInPosition() {
    return widgets.map((module) => providePositioned(module)).toList();
  }

  void correctWidgetPosition(double tempLeft, double tempTop, PowerWidget widget) {
    if (tempLeft >= xMax - getSize(widget).width) {
      widget.left = xMax - getSize(widget).width;
    } else if (tempLeft <= xMin) {
      widget.left = xMin;
    } else {
      widget.left = tempLeft;
    }

    if (tempTop >= yMax - getSize(widget).height) {
      widget.top = yMax - getSize(widget).height;
    } else if (tempTop <= yMin) {
      widget.top = yMin;
    } else {
      widget.top = tempTop;
    }
  }

  Positioned providePositioned(PowerWidget widget) {
    return Positioned(
      top: widget.top < yMin ? yMin : widget.top,
      left: widget.left < xMin ? xMin : widget.left,
      child: GestureDetector(
        child: widget,
        onPanUpdate: (DragUpdateDetails e) {
          widget.onMoving();
          setState(() {
            double tempLeft = widget.left + e.delta.dx;
            double tempTop = widget.top + e.delta.dy;
            correctWidgetPosition(tempLeft, tempTop, widget);
          });
        },
        onTap: () {
          widget.onTap();
        },
        onPanEnd: (DragEndDetails e) {
          widget.onMoved();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: getWidgetsInPosition());
  }
}
