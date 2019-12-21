import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Render time in a modern format.
class ModernTime extends StatelessWidget {
  const ModernTime({
    Key key,
    @required this.time,
    this.is24HourFormat = true,
  }) : super(key: key);

  final DateTime time;
  final bool is24HourFormat;

  bool _isDarkTheme(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

  String get _formattedTime =>
    (is24HourFormat ? DateFormat.Hms() : DateFormat.jms()).format(time);

  @override
  Widget build(BuildContext context) => Text(
    _formattedTime,
    style: TextStyle(
      color: _isDarkTheme(context) ? Colors.white70 : Colors.black45,
      fontSize: 12,
      fontFamily: 'Menlo',
    ),
  );
}
