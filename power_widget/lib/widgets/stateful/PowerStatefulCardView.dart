import 'package:flutter/widgets.dart';
import 'package:power_widget/serializable/SerializableStatefulWidget.dart';
import 'package:power_widget/serializable/WidgetSerializableModel.dart';
import 'package:power_widget/widgets/PowerCardView.dart';

abstract class PowerStatefulCardView extends SerializableStatefulWidget with PowerCardView {
  PowerStatefulCardViewState state;
  GlobalKey globalKey = GlobalKey();
  Widget widget;

  PowerStatefulCardView(this.widget);

  @override
  State<StatefulWidget> createState() {
    return PowerStatefulCardViewState(getSize(), provideCardViewPainter(), this, globalKey, this.widget);
  }

  @override
  WidgetSerializableModel getWidgetSerializableModel() {
    // TODO: implement getWidgetSerializableModel
    return null;
  }

  void notifyWidgetUpdate() {
    globalKey.currentState.setState(() => {});
  }
}

class PowerStatefulCardViewState extends State<PowerStatefulCardView> {
  CustomPainter customPainter;
  Stack childrenStack;
  Size size;
  PowerCardView powerCardView;
  GlobalKey globalKey = GlobalKey();
  final Widget mainWidget;

  PowerStatefulCardViewState(this.size, this.customPainter, this.powerCardView, this.globalKey, this.mainWidget);

  @override
  Widget build(BuildContext context) {
    CustomPaint customPaint;
    customPaint = CustomPaint(child: mainWidget, size: powerCardView.getSize(), painter: powerCardView.provideCardViewPainter());
    return Center(
      child: customPaint,
    );
  }
}
