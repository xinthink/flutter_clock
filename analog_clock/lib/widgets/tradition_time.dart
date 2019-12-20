import 'package:analog_clock/tradition_time_util.dart';
import 'package:flutter/material.dart';

/// Render time in a traditional (Chinese) format.
class TraditionTime extends StatelessWidget {
  /// Instantiate a [TraditionTime] widget.
  ///
  /// Given the [time] to be rendered, and an optional [mainAxisAlignment].
  TraditionTime({
    Key key,
    @required this.time,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  final DateTime time;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _renderQuarter(),
      const SizedBox(width: 12),
      _renderHour(),
    ],
  );

  Widget _renderHour() => Column(
    mainAxisSize: MainAxisSize.min,
    children: toTraditionHour(time)
      .map((s) => Text(s,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 48,
          fontFamily: 'XingKaiFan',
        ),
      )).toList(),
  );

  Widget _renderQuarter() => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: toTraditionQuarter(time)
        .map((s) => Text(s,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'XingKaiFan',
          ),
        )).toList(),
    ),
  );
}
