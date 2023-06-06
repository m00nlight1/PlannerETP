import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xFF0d74ba);
    paint.style = PaintingStyle.fill;

    var path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, 0, 100, 30), const Radius.circular(15)))
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
