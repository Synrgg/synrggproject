import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamingBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white24.withOpacity(0.1);

    // Draw a faint grid pattern
    for (double x = 0; x < size.width; x += 40) {
      for (double y = 0; y < size.height; y += 40) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }

    // Add light flares or shapes
    final flarePaint = Paint()..color = Colors.white.withOpacity(0.08);
    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.4), 80, flarePaint);
    canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.6), 60, flarePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
