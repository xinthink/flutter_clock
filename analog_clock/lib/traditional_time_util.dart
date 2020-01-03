import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

/// Total distance traveled by the dial or gnomon, each second.
final kRadiansPerTick = radians(360 / 86400);

/// List of [Celestial Stems](https://en.wikipedia.org/wiki/Heavenly_Stems)
final kCelestialStems = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];

/// List of [Earthly Branches](https://en.wikipedia.org/wiki/Earthly_Branches)
final kEarthlyBranches = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];

/// Sectors of each [Double Hour](https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping)
final kTraditionSectors = ['初', '正'];

/// Traditional quarters
final kTraditionQuarters = ['初', '一', '二', '三'];

/// Code point of each character in the traditional XiaoZhuan fonts
final kZhuanCodePoints = <String, IconData>{
  '子': const IconData(0xe900, fontFamily: 'ZhuanSundial'),
  '丑': const IconData(0xe901, fontFamily: 'ZhuanSundial'),
  '寅': const IconData(0xe902, fontFamily: 'ZhuanSundial'),
  '卯': const IconData(0xe903, fontFamily: 'ZhuanSundial'),
  '辰': const IconData(0xe904, fontFamily: 'ZhuanSundial'),
  '巳': const IconData(0xe905, fontFamily: 'ZhuanSundial'),
  '午': const IconData(0xe906, fontFamily: 'ZhuanSundial'),
  '未': const IconData(0xe907, fontFamily: 'ZhuanSundial'),
  '申': const IconData(0xe908, fontFamily: 'ZhuanSundial'),
  '酉': const IconData(0xe909, fontFamily: 'ZhuanSundial'),
  '戌': const IconData(0xe90a, fontFamily: 'ZhuanSundial'),
  '亥': const IconData(0xe90b, fontFamily: 'ZhuanSundial'),
  '初': const IconData(0xe90c, fontFamily: 'ZhuanSundial'),
  '正': const IconData(0xe90d, fontFamily: 'ZhuanSundial'),
  '一': const IconData(0xe90e, fontFamily: 'ZhuanSundial'),
  '二': const IconData(0xe90f, fontFamily: 'ZhuanSundial'),
  '三': const IconData(0xe910, fontFamily: 'ZhuanSundial'),
  '刻': const IconData(0xe911, fontFamily: 'ZhuanSundial'),
  '甲': const IconData(0xe912, fontFamily: 'ZhuanSundial'),
  '乙': const IconData(0xe913, fontFamily: 'ZhuanSundial'),
  '丙': const IconData(0xe914, fontFamily: 'ZhuanSundial'),
  '丁': const IconData(0xe915, fontFamily: 'ZhuanSundial'),
  '戊': const IconData(0xe916, fontFamily: 'ZhuanSundial'),
  '己': const IconData(0xe917, fontFamily: 'ZhuanSundial'),
  '庚': const IconData(0xe918, fontFamily: 'ZhuanSundial'),
  '辛': const IconData(0xe918, fontFamily: 'ZhuanSundial'),
  '壬': const IconData(0xe91a, fontFamily: 'ZhuanSundial'),
  '癸': const IconData(0xe91b, fontFamily: 'ZhuanSundial'),
};

/// Code point of each character in the traditional WebBei fonts
final _kWeiBeiCodePoints = <String, IconData>{
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
  final strHour = kEarthlyBranches[idxHour ~/ 2];
  final strSector = kTraditionSectors[idxHour % 2];
  return [strHour, strSector];
}

/// Transform [time] to quarters in traditional format, an empty result means `zero`.
///
/// See [刻](https://zh.wikipedia.org/wiki/%E5%88%BB)
/// and [Double Hour](https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping)
@visibleForTesting
List<String> toTraditionalQuarterStrings(DateTime time) {
  final q = kTraditionQuarters[time.minute ~/ 15];
  return q.isNotEmpty ? [q, '刻'] : [];
}

/// Transform [time] to hours in traditional format.
///
/// See [Twelve branches](https://en.wikipedia.org/wiki/Earthly_Branches)
Iterable<IconData> toTraditionalHour(DateTime time) =>
  toTraditionalHourStrings(time).map((c) => _kWeiBeiCodePoints[c]);

/// Transform [time] to quarters in traditional format, an empty result means `zero`.
///
/// See [刻](https://zh.wikipedia.org/wiki/%E5%88%BB)
/// and [Double Hour](https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping)
Iterable<IconData> toTraditionalQuarter(DateTime time) =>
  toTraditionalQuarterStrings(time).map((c) => _kWeiBeiCodePoints[c]);
