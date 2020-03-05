library serializable;

class WidgetSerializableModel {
  final double top;
  final double left;
  final double right;
  final double bottom;
  double width = -1;
  double height = -1;

  WidgetSerializableModel(this.left, this.top, this.right, this.bottom) {
    this.width = this.right - this.left;
    this.height = this.bottom - this.top;
  }
}
