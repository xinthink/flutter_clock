import 'package:analog_clock/traditional_time_util.dart';
import 'package:flutter/material.dart';

import 'cross_fade_text.dart';

/// Render time in a traditional (Chinese) format.
class TraditionalTime extends StatelessWidget {
  /// Instantiate a [TraditionalTime] widget.
  ///
  /// Given the [time] to be rendered, and an optional [mainAxisAlignment].
  TraditionalTime({
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
      _renderQuarter(context),
      const SizedBox(width: 12),
      _renderHour(context),
    ],
  );

  Widget _renderHour(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: toTraditionalHour(time)
      .map((s) => CrossFadeText(
        text: s,
        style: TextStyle(
          fontSize: 48,
          fontFamily: 'XingKaiFan',
        ),
      )).toList(),
  );

  Widget _renderQuarter(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: toTraditionalQuarter(time)
        .map((s) => CrossFadeText(
          text: s,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'XingKaiFan',
          ),
        )).toList(),
    ),
  );
}
