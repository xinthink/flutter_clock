import 'package:flutter/material.dart';

import 'drawn_sundial_container.dart';
import 'gnomon_painter.dart';

/// Draw the gnomon component of the Sundial
class DrawnGnomon extends StatelessWidget {
  /// Instantiate a [DrawnGnomon] given the rotation [radians].
  const DrawnGnomon({
    Key key,
    this.radians = 0,
  }) : super(key: key);

  /// The rotation angle in radians
  final double radians;

  @override
  Widget build(BuildContext context) => DrawnSundialContainer(
    painter: GnomonPainter(
      isDarkTheme: Theme.of(context).brightness == Brightness.dark,
      radians: radians,
    ),
  );
}
