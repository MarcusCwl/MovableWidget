import 'package:flutter/widgets.dart';
import 'package:power_widget/serializable/SerializableStatefulWidget.dart';
import 'package:power_widget/serializable/SerializableWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';

abstract class ModularizedStatefulWidget extends SerializableStatefulWidget {
  final List<SerializableStatefulWidget> widgets = new List();

  void addChildWidget(SerializableWidget child) {
    widgets.add(child);
  }

  Stack provideChildrenStack() {
    return Stack(children: provideWidget(), alignment: Alignment.topLeft);
  }

  List<Widget> provideWidget() {
    return widgets.map((widget) => providePositioned(widget)).toList();
  }

  Positioned providePositioned(SerializableStatefulWidget widget) {
    WidgetSerializableModel model = widget.getWidgetSerializableModel();
    return Positioned.fromRect(child: widget, rect: Rect.fromLTRB(model.left, model.top, model.right, model.bottom));
  }
}
