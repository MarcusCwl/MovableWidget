library dynamic_widget;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:power_widget/serializable/SerializableStatefulWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';
import 'package:power_widget/widgets/PowerWidget.dart';

// ignore: must_be_immutable
class DynamicFrameModule extends SerializableStatefulWidget {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final List<PowerWidget> widgets;

  //Key of Widget which need to show and impl movable statement
  //We use this to get size of widget

  DynamicFrameModuleState state;

  DynamicFrameModule(this.left, this.top, this.right, this.bottom, this.widgets) {
    this.state = DynamicFrameModuleState(left, top, right, bottom, widgets);
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

class DynamicFrameModuleState extends State<DynamicFrameModule> with SingleTickerProviderStateMixin {
  final double xMin;
  final double yMin;
  final double xMax;
  final double yMax;
  final List<PowerWidget> widgets;

  DynamicFrameModuleState(this.xMin, this.yMin, this.xMax, this.yMax, this.widgets);

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

  Positioned providePositioned(PowerWidget widget) {
    return Positioned(top: widget.top < yMin ? yMin : widget.top, left: widget.left < xMin ? xMin : widget.left, child: widget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: getWidgetsInPosition());
  }
}
