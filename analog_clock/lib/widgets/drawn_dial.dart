import 'package:collection_ext/iterables.dart' hide Transform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import '../traditional_time_util.dart';
import 'dial_painter.dart';
import 'drawn_sundial_container.dart';

/// Draw the dial component of the Sundial
///
/// This implementation is a combination of [Transform.rotate] & [CustomPaint],
/// for the [Canvas] doesn't support well for rotated text & svg
class DrawnDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DrawnSundialContainer(
    painter: DialPainter(
      isDarkTheme: Theme.of(context).brightness == Brightness.dark,
    ),
    builder: _buildTimeMarks,
  );

  Widget _buildTimeMarks(BuildContext context, double size) => Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        _buildGnomonBottom(size),
        ..._buildBrancheMarks(context, size),
        ..._buildStemMarks(context, size),
        ..._buildSectorMarks(context, size),
      ],
    ),
  );

  /// Bottom of the Gnomon.
  /// For web, the svg widget has problems on size & position, use pngs instead.
  Widget _buildGnomonBottom(double size) => SizedBox(
    width: size * 0.14,
    height: size * 0.14,
    child: kIsWeb
      ? Image.asset('assets/images/gnomon-bottom.png', semanticLabel: 'Gnomon Bottom')
      : SvgPicture.asset( 'assets/images/gnomon-bottom.svg', semanticsLabel: 'Gnomon Bottom'),
  );

  /// Marks for [Earthly Branches](https://en.wikipedia.org/wiki/Earthly_Branches)
  Iterable<Widget> _buildBrancheMarks(BuildContext context, double size) =>
    kEarthlyBranches.mapIndexed((i, b) =>
      _buildRotatedText(context, b,
        diameter: size * 0.68,
        angle: i * 30.0 + 180,
        size: size * 0.077,
        color: Theme.of(context).primaryTextTheme.title.color,
    ));

  /// Marks for [Celestial Stems](https://en.wikipedia.org/wiki/Heavenly_Stems)
  Iterable<Widget> _buildStemMarks(BuildContext context, double size) =>
    kCelestialStems.mapIndexed((i, stem) =>
      _buildRotatedText(context, stem,
        diameter: size * 0.4,
        angle: i * 36.0,
        size: size * 0.046,
        color: Theme.of(context).primaryTextTheme.subtitle.color,
    ));

  /// Marks for sectors for each [Double Hour](https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping)
  Iterable<Widget> _buildSectorMarks(BuildContext context, double size) {
    final widgets = <Widget>[];
    int i = 0;
    while (i < 24) {
      kTraditionSectors.mapToList(widgets, (sector) =>
        _buildRotatedText(context, sector,
          diameter: size * 0.905,
          angle: i++ * 15.0 - 7.5,
          size: size * 0.046,
          color: Theme.of(context).primaryTextTheme.subtitle.color,
      ));
    }
    return widgets;
  }

  Widget _buildRotatedText(BuildContext context, String text, {
    double diameter,
    double angle,
    double size = 30,
    Color color = Colors.black87,
  }) => Transform.rotate(
    angle: radians(angle),
    child: Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.bottomCenter,
      child: Icon(
        kZhuanCodePoints[text],
        size: size,
        color: color,
      ),
    ),
  );
}
