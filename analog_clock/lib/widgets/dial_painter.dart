import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

/// Draw the dial (a rounded flat plate) of the Sundial
class DialPainter extends CustomPainter {
  /// Construct a [DialPainter], given [isDarkTheme] if it should use a dark theme.
  DialPainter({
    this.isDarkTheme = false,
  });

  final bool isDarkTheme;

  final _dialPaint = Paint()
    ..isAntiAlias = true;
  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    double dia = math.min(size.width, size.height);
    final linePaint = _linePaint
      ..strokeWidth = isDarkTheme ? 1 : 1.5
      ..color = isDarkTheme ? _kLineColorDark : _kLineColor;

    // background
    canvas.drawCircle(Offset(dia / 2, dia / 2), dia / 2, _dialPaint
      ..color = isDarkTheme ? _kDialColorDark : _kDialColor
    );

    // circles
    _paintCircle(canvas, dia, 1, linePaint);
    _paintCircle(canvas, dia, 0.95, linePaint);
    _paintCircle(canvas, dia, 0.75, linePaint);
    _paintCircle(canvas, dia, 0.45, linePaint);
    _paintCircle(canvas, dia, 0.25, linePaint);

    // radialized time-lines
    _paintSpokes(canvas, linePaint, dia, 0.95, 1, 3.75);
    _paintSpokes(canvas, linePaint, dia, 0.75, 0.95, 15);
    _paintSpokes(canvas, linePaint, dia, 0.45, 0.75, 30, 15);
    _paintSpokes(canvas, linePaint, dia, 0.25, 0.45, 36, 18);
  }

  /// Draw a concentric circle which separates different kinds of marks on the dial
  void _paintCircle(Canvas canvas, double size, double ratio, Paint paint) {
    final dia = size * ratio;
    final r = dia / 2;
    canvas.drawCircle(Offset(size / 2, size / 2), r, paint);
  }

  /// Draw radialized divivers between time marks on the dial, which are simliar to spokes
  void _paintSpokes(Canvas canvas, Paint paint,
    double size, double innerRatio, double outerRatio,
    double stepAngle, [double offsetAngle = 0]
  ) {
    final x0 = size / 2;
    final y0 = size / 2;
    final r1 = size * innerRatio / 2;
    final r2 = size * outerRatio / 2;
    double angle = offsetAngle;
    while (angle < 360) {
      final radians = vmath.radians(angle);
      final p1 = Offset(x0 + r1 * math.sin(radians), y0 + r1 * math.cos(radians));
      final p2 = Offset(x0 + r2 * math.sin(radians), y0 + r2 * math.cos(radians));
      canvas.drawLine(p1, p2, paint);
      angle += stepAngle;
    }
  }

  @override
  bool shouldRepaint(DialPainter oldDelegate) =>
    oldDelegate.isDarkTheme != isDarkTheme;
}

const _kDialColor =Color(0xFFDFDEDC);
const _kDialColorDark =Color(0xFF121212);
const _kLineColor =Color(0xBFBBBBBB);
const _kLineColorDark =Color(0x66BBBBBB);
