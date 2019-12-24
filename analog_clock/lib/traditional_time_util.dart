import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

/// Total distance traveled by the dial or gnomon, each second.
final kRadiansPerTick = radians(360 / 86400);

final kTraditionHours = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
final kTraditionSectors = ['初', '正'];
final kTraditionQuarters = ['初', '一', '二', '三'];
final _kCodePoints = <String, IconData>{
  '子': const IconData(0xe900, fontFamily: 'WeiBeiSundial'),
  '丑': const IconData(0xe901, fontFamily: 'WeiBeiSundial'),
  '寅': const IconData(0xe902, fontFamily: 'WeiBeiSundial'),
  '卯': const IconData(0xe903, fontFamily: 'WeiBeiSundial'),
  '辰': const IconData(0xe904, fontFamily: 'WeiBeiSundial'),
  '巳': const IconData(0xe905, fontFamily: 'WeiBeiSundial'),
  '午': const IconData(0xe906, fontFamily: 'WeiBeiSundial'),
  '未': const IconData(0xe907, fontFamily: 'WeiBeiSundial'),
  '申': const IconData(0xe908, fontFamily: 'WeiBeiSundial'),
  '酉': const IconData(0xe909, fontFamily: 'WeiBeiSundial'),
  '戌': const IconData(0xe90a, fontFamily: 'WeiBeiSundial'),
  '亥': const IconData(0xe90b, fontFamily: 'WeiBeiSundial'),
  '初': const IconData(0xe90c, fontFamily: 'WeiBeiSundial'),
  '正': const IconData(0xe90d, fontFamily: 'WeiBeiSundial'),
  '一': const IconData(0xe90e, fontFamily: 'WeiBeiSundial'),
  '二': const IconData(0xe90f, fontFamily: 'WeiBeiSundial'),
  '三': const IconData(0xe910, fontFamily: 'WeiBeiSundial'),
  '刻': const IconData(0xe911, fontFamily: 'WeiBeiSundial'),
};

/// Transform [time] to hours in traditional format.
///
/// See [Twelve branches](https://en.wikipedia.org/wiki/Earthly_Branches)
@visibleForTesting
List<String> toTraditionalHourStrings(DateTime time) {
  final idxHour = time.hour < 23 ? time.hour + 1 : 0; // +1 offset & map index of 23:00 to 0
  final strHour = kTraditionHours[idxHour ~/ 2];
  final strSector = kTraditionSectors[idxHour % 2];
  return [strHour, strSector];
}

/// Transform [time] to quarters in traditional format, an empty result means `zero`.
///
/// See [刻](https://zh.wikipedia.org/wiki/%E5%88%BB) (English page unavailable)
@visibleForTesting
List<String> toTraditionalQuarterStrings(DateTime time) {
  final q = kTraditionQuarters[time.minute ~/ 15];
  return q.isNotEmpty ? [q, '刻'] : [];
}

/// Transform [time] to hours in traditional format.
///
/// See [Twelve branches](https://en.wikipedia.org/wiki/Earthly_Branches)
Iterable<IconData> toTraditionalHour(DateTime time) =>
  toTraditionalHourStrings(time).map((c) => _kCodePoints[c]);

/// Transform [time] to quarters in traditional format, an empty result means `zero`.
///
/// See [刻](https://zh.wikipedia.org/wiki/%E5%88%BB) (English page unavailable)
Iterable<IconData> toTraditionalQuarter(DateTime time) =>
  toTraditionalQuarterStrings(time).map((c) => _kCodePoints[c]);
