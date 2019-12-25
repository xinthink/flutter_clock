import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Draw the gnomon of the Sundial
class GnomonPainter extends CustomPainter {
  /// Construct a [GnomonPainter], given [isDarkTheme] if it should use a dark theme.
  GnomonPainter({
    this.radians = 0,
    this.isDarkTheme = false,
  });

  final double radians;
  final bool isDarkTheme;

  Color get _pinColor => isDarkTheme ? _kPinColorDark : _kPinColor;
  Color get _shadowColor => isDarkTheme ? _kShadowColorDark : _kShadowColor;

  final _pinPaint = Paint()
    ..isAntiAlias = true;
  final _shadowPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true;
  final _pointerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = _kPointerColorDark
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    double dia = math.min(size.width, size.height);
    final center = Offset(dia / 2, dia / 2);
    final pinWidth = dia * _kPinWidthRatio;
    final pinpointWidth = dia * _kPinpointWidthRatio;

    // pin
    final pinPaint = _pinPaint..color = _pinColor;
    canvas.drawCircle(center, pinWidth, pinPaint); // bottom
    canvas.drawCircle(center, pinpointWidth, pinPaint); // pinpoint

    // shadow of the pin (gnomon)
    final shadowPaint = _shadowPaint
      ..strokeWidth = isDarkTheme ? 1 : pinWidth
      ..color = _shadowColor;
    final shadowRadius = dia * _kShadowLengthRatio / 2;
    final shadowDx = shadowRadius * math.sin(radians);
    final shadowDy = shadowRadius * math.cos(radians);
    final pinpoint = Offset(center.dx - shadowDx, center.dy + shadowDy);
    canvas.drawLine(center, pinpoint, shadowPaint);

    // draw a fluorescent pointer for dark theme
    if (isDarkTheme) {
      final r1 = _kPointerInnerRatio * dia;
      final r2 = _kPointerOuterRatio * dia;
      final dx1 = r1 * math.sin(radians);
      final dy1 = r1 * math.cos(radians);
      final dx2 = r2 * math.sin(radians);
      final dy2 = r2 * math.cos(radians);
      canvas.drawLine(
        Offset(center.dx - dx1, center.dy + dy1),
        Offset(center.dx - dx2, center.dy + dy2),
        _pointerPaint
      );
    }
  }

  @override
  bool shouldRepaint(GnomonPainter oldDelegate) =>
    oldDelegate.isDarkTheme != isDarkTheme ||
    oldDelegate.radians != radians;
}

const _kPinWidthRatio = 0.008;
const _kPinpointWidthRatio = _kPinWidthRatio / 2;
const _kShadowLengthRatio = 0.97;
const _kPointerInnerRatio = 0.44;
const _kPointerOuterRatio = 0.47;

const _kPinColor = Color(0xCC333333);
const _kPinColorDark = Color(0xB222CCDD);
const _kShadowColor = Color(0xB2333333);
const _kShadowColorDark = Color(0x8022CCDD);
const _kPointerColorDark = Color(0xFF22CCDD);
