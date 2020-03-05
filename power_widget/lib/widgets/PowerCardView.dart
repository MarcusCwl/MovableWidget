import 'package:flutter/widgets.dart';

abstract class PowerCardView {
  Rect getRect();

  Size getSize();

  Color getBackgroundColor();

  CustomPainter provideCardViewPainter() {
    return CardViewPainter(getRect(), getBackgroundColor());
  }
}

class CardViewPainter extends CustomPainter {
  final Rect rect;
  final Color backgroundColor;

  CardViewPainter(this.rect, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    double cardWidth = this.rect.width;
    double cardHeight = this.rect.height;
    double startX = this.rect.left;
    double startY = this.rect.top;

    Size drawingSize = Size(cardWidth, cardHeight);
    Rect rect = Offset(startX, startY) & drawingSize;

    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = this.backgroundColor;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
