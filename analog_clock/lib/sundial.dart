import 'dart:async';

import 'package:analog_clock/widgets/digital_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'traditional_time_util.dart';
import 'widgets/digital_time.dart';
import 'widgets/traditional_time.dart';

/// An analog clock inspired by the ancient chinese timing device: [Sundial](https://en.wikipedia.org/wiki/Sundial).
class Sundial extends StatefulWidget {
  /// Instantiate a [Sundial] widget, given the clock [model].
  const Sundial({
    Key key,
    this.model,
  }) : super(key: key);

  final ClockModel model;

  @override
  State<StatefulWidget> createState() => _SundialState();
}

/// [State] of the [Sundial] widget.
class _SundialState extends State<Sundial> {
  DateTime _now = DateTime.now();
  Timer _timer;

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(Sundial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  void _updateModel() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) => Container(
    decoration: _isDarkTheme ? null : BoxDecoration(
      gradient: RadialGradient(
        center: const Alignment(0.25, -1.0),
        radius: 1.5,
        colors: [
          const Color(0xFFE3EAC7),
          const Color(0xFF8F8E5B),
        ],
      ),
    ),
    child: Row(
      children: <Widget>[
        _buildTimeText(),
        _buildSundial(),
      ],
    ),
  );

  Widget _buildSundial() => Expanded(
    flex: 7,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildSundialPlate(),
        _buildGnomon(),
      ],
    ),
  );

  /// Plate of the Sundial, which marked with hour-lines.
  Widget _buildSundialPlate() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Transform.rotate(
      angle: _calcAngle(),
      child: Image.asset(
        "assets/images/sundial${_isDarkTheme ? '-dark' : ''}.png",
        fit: BoxFit.cover,
      ),
    ),
  );

  /// [Gnomon](https://en.wikipedia.org/wiki/Gnomon) which casts a shadow onto the dial to indicate the time of the day.
  Widget _buildGnomon() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Image.asset(
      "assets/images/gnomon${_isDarkTheme ? '-dark' : ''}.png",
    ),
  );

  /// Render time as text
  Widget _buildTimeText() => Expanded(
    flex: 3,
    child: Column(
      children: <Widget>[
        _renderTraditionalTime(),
        _renderDigits(),
      ],
    ),
  );

  /// Render time in a traditional format
  Widget _renderTraditionalTime() => Expanded(
    child: Container(
      alignment: Alignment.center,
      child: TraditionalTime(
        time: _now,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    ),
  );

  /// Render time in digits
  Widget _renderDigits() => Expanded(
    child: Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: DigitalTime(
        time: _now,
        is24HourFormat: widget.model.is24HourFormat,
      ),
    ),
  );

  /// Calculate rotation angle of the dial or gnomon.
  ///
  /// For the dial:
  /// - should rotate in counter-clockwise [direction]
  /// - there is a 180° [offset], because we always show the current time at the bottom center
  ///
  /// However, the gnomon (shadow), should travel clockwise, with no offset.
  double _calcAngle([int direction = -1, double offset = 180]) {
    final s = _now.hour * 3600 + _now.minute * 60 + _now.second; // seconds elapsed since 00:00:00
    // debugPrint("--- ts=$s, angle=${s * radiansPerTick} (${s * 360 / 86400}°)");
    return direction * s * kRadiansPerTick + radians(offset);
  }
}
