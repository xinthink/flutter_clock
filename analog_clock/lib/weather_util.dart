import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

const _kIconsFont = 'weathericons';

/// Map the given weather [condition] to an icon
IconData getWeatherIcon(WeatherCondition condition) {
  int code = 0;
  switch (condition) {
    case WeatherCondition.cloudy:
      code = 0xf013;
      break;
    case WeatherCondition.foggy:
      code = 0xf014;
      break;
    case WeatherCondition.rainy:
      code = 0xf019;
      break;
    case WeatherCondition.snowy:
      code = 0xf01b;
      break;
    case WeatherCondition.sunny:
      code = 0xf00d;
      break;
    case WeatherCondition.thunderstorm:
      code = 0xf01e;
      break;
    case WeatherCondition.windy:
      code = 0xf050;
      break;
  }
  return IconData(code, fontFamily: _kIconsFont);
}
