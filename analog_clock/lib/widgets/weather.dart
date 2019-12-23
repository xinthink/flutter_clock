import 'package:analog_clock/weather_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

/// Widget rendering weather/location info
class Weather extends StatelessWidget {
  /// Instantiate a [Weather] widget, given the [model].
  const Weather({
    Key key,
    this.model,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.crossAxisAlignment = CrossAxisAlignment.end,
  }) : super(key: key);

  final ClockModel model;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    children: <Widget>[
      _buildTemperature(context),
      const SizedBox(height: 4),
      _buildWeather(context),
      const SizedBox(height: 4),
      _buildLocation(context),
    ],
  );

  Widget _buildTemperature(BuildContext context) => Text(
    model.temperatureString,
    style: TextStyle(
      fontSize: 24,
      color: Theme.of(context).primaryTextTheme.title.color,
    ),
  );

  Widget _buildWeather(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Icon(
          getWeatherIcon(model.weatherCondition),
          size: 16,
          color: Theme.of(context).primaryTextTheme.subtitle.color,
        ),
      ),
      const SizedBox(width: 6),
      Text(
        "${model.low} / ${model.highString}",
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).primaryTextTheme.subtitle.color,
        ),
      ),
    ],
  );

  Widget _buildLocation(BuildContext context) => Text(
    model.location,
    style: TextStyle(
      fontSize: 12,
      color: Theme.of(context).primaryTextTheme.caption.color,
    ),
  );
}
