import 'package:analog_clock/traditional_time_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// See [Twelve branches](https://en.wikipedia.org/wiki/Earthly_Branches)
  test('Map hours to traditional representation', () {
    expect(toTraditionalHour(DateTime(2019, 12, 31, 23)), equals(['子', '初']));
    expect(toTraditionalHour(DateTime(2019, 12, 31, 23, 59, 59)), equals(['子', '初']));
    expect(toTraditionalHour(DateTime(2020)), equals(['子', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 1)), equals(['丑', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 2)), equals(['丑', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 3)), equals(['寅', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 4)), equals(['寅', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 5)), equals(['卯', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 6)), equals(['卯', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 7)), equals(['辰', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 8)), equals(['辰', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 9)), equals(['巳', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 10)), equals(['巳', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 11)), equals(['午', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 12)), equals(['午', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 13)), equals(['未', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 14)), equals(['未', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 15)), equals(['申', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 16)), equals(['申', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 17)), equals(['酉', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 18)), equals(['酉', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 19)), equals(['戌', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 20)), equals(['戌', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 21)), equals(['亥', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 22)), equals(['亥', '正']));
    expect(toTraditionalHour(DateTime(2020, 1, 1, 23)), equals(['子', '初']));
    expect(toTraditionalHour(DateTime(2020, 1, 2)), equals(['子', '正']));
  });

  /// See [刻](https://zh.wikipedia.org/wiki/%E5%88%BB)
  test('Map quarters to traditional representation', () {
    expect(toTraditionalQuarter(DateTime(2020, 1, 1, 1)), equals(['初', '刻']));
    expect(toTraditionalQuarter(DateTime(2020, 1, 1, 1, 15)), equals(['一', '刻']));
    expect(toTraditionalQuarter(DateTime(2020, 1, 1, 1, 30)), equals(['二', '刻']));
    expect(toTraditionalQuarter(DateTime(2020, 1, 1, 1, 45)), equals(['三', '刻']));
    expect(toTraditionalQuarter(DateTime(2020, 1, 1, 2)), equals(['初', '刻']));
  });
}
