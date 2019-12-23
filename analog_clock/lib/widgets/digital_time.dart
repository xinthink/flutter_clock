import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Render time in digital format.
class DigitalTime extends StatelessWidget {
  const DigitalTime({
    Key key,
    @required this.time,
    this.is24HourFormat = true,
  }) : super(key: key);

  final DateTime time;
  final bool is24HourFormat;

  String get _formattedTime =>
    (is24HourFormat ? DateFormat.Hms() : DateFormat.jms()).format(time);

  @override
  Widget build(BuildContext context) => Text(
    _formattedTime,
    style: TextStyle(
      color: Theme.of(context).primaryTextTheme.caption.color,
      fontSize: 10,
      fontFamily: 'Menlo',
    ),
  );
}
