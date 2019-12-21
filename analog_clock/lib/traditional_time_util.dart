import 'package:vector_math/vector_math_64.dart' show radians;

/// Total distance traveled by the dial or gnomon, each second.
final kRadiansPerTick = radians(360 / 86400);

final kTraditionHours = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
final kTraditionSectors = ['初', '正'];
final kTraditionQuarters = ['初', '一', '二', '三'];

/// Transform [time] to hours in traditional format.
///
/// See [Twelve branches](https://en.wikipedia.org/wiki/Earthly_Branches)
List<String> toTraditionalHour(DateTime time) {
  final idxHour = time.hour < 23 ? time.hour + 1 : 0; // +1 offset & map index of 23:00 to 0
  final strHour = kTraditionHours[idxHour ~/ 2];
  final strSector = kTraditionSectors[idxHour % 2];
  return [strHour, strSector];
}

/// Transform [time] to quarters in traditional format, an empty result means `zero`.
///
/// See [刻](https://zh.wikipedia.org/wiki/%E5%88%BB) (English page unavailable)
List<String> toTraditionalQuarter(DateTime time) {
  final q = kTraditionQuarters[time.minute ~/ 15];
  return q.isNotEmpty ? [q, '刻'] : [];
}
