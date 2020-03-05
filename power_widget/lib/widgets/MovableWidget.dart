library movable_widget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:power_widget/listener/WidgetEventListener.dart';
import 'package:power_widget/serializable/SerializableStatefulWidget.dart';
import 'package:power_widget/serializable/SerializableStatelessWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';

// ignore: must_be_immutable
abstract class MovableWidget extends SerializableStatelessWidget {
  double top;
  double left;
  double right;
  double bottom;

  //Widget which need to show and impl movable statement
  final Widget widget;

  final GlobalKey globalKey;

  MovableWidget(this.left, this.top, this.right, this.bottom, this.widget, this.globalKey);

  @override
  WidgetSerializableModel getWidgetSerializableModel() {
    return WidgetSerializableModel(left, top, right, bottom);
  }

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}
