import 'package:flutter/widgets.dart';
import 'package:power_widget/serializable/SerializableStatelessWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';

abstract class ModularizedStatelessWidget extends SerializableStatelessWidget {
  Stack provideChildrenStack() {
    return Stack(children: provideWidgets());
  }

  List<Widget> provideWidgets() {
    return getChildWidgets().map((widget) => providePositioned(widget)).toList();
  }

  Positioned providePositioned(SerializableStatelessWidget widget) {
    WidgetSerializableModel model = widget.getWidgetSerializableModel();
    return Positioned(width: model.width, height: model.height, top: model.top, bottom: model.bottom, left: model.left, right: model.right, child: widget);
  }

  List<SerializableStatelessWidget> getChildWidgets();
}
