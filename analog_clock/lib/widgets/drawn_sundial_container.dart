import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Wrapper of a sundial component
class DrawnSundialContainer extends StatelessWidget {
  /// Instantiate a [DrawnSundialContainer], with a [painter] & a [builder].
  const DrawnSundialContainer({
    Key key,
    @required this.painter,
    this.builder,
  }) : super(key: key);

  final CustomPainter painter;
  final Function(BuildContext context, double size) builder;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(32),
    child: Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = math.min(constraints.maxWidth, constraints.maxHeight);
          return SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: painter,
              child: builder?.call(context, size),
            ),
          );
        },
      ),
    ),
  );
}
