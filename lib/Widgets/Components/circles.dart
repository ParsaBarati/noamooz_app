import 'package:flutter/material.dart';
import 'package:noamooz_app/Utils/color_utils.dart';

class CircleOne extends CustomPainter {
  late final Paint _paint;

  CircleOne([Color? color]) {
    color ??= ColorUtils.white.withOpacity(0.2);
    _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  late final Paint _paint;

  CircleTwo([Color? color]) {
    color ??= ColorUtils.white.withOpacity(0.2);

    _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
