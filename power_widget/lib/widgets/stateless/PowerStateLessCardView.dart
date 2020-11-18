import 'package:flutter/widgets.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';
import 'package:power_widget/widgets/PowerCardView.dart';
import 'package:power_widget/widgets/stateless/ModularizedStatelessWidget.dart';

abstract class PowerStatelessCardView extends ModularizedStatelessWidget with PowerCardView {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CustomPaint(
        child: provideChildrenStack(),
        size: getSize(),
        painter: provideCardViewPainter(),
      ),
    );
  }

  @override
  WidgetSerializableModel getWidgetSerializableModel() {
    // TODO: implement getWidgetSerializableModel
    return null;
  }
}
