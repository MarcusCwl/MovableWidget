import 'package:flutter/widgets.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';

abstract class SerializableWidget extends StatefulWidget {
  WidgetSerializableModel getWidgetSerializableModel();
}
