import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Render time in a traditional (Chinese) format.
class ModernTime extends StatelessWidget {
  const ModernTime({
    Key key,
    @required this.time,
  }) : super(key: key);

  final DateTime time;

  @override
  Widget build(BuildContext context) => Text(
    DateFormat.Hms().format(time),
    style: const TextStyle(
      color: Colors.black38,
      fontSize: 12,
      fontFamily: 'Menlo',
    ),
  );
}
