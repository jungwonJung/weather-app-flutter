import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeahterPage extends StatefulWidget {
  const WeahterPage({super.key});

  @override
  State<WeahterPage> createState() => _WeahterPageState();
}

class _WeahterPageState extends State<WeahterPage> {
  // api key
  final _weatherService = WeatherService('daa750779d9733980bbeab0c96e6e3b1');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the cuttrent city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // weather animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clase':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0), // Adjust margin as needed
            child: Text(
              _weather?.cityName ?? "loading city..",
              style: TextStyle(
                  fontSize: 24.0, // Adjust font size as needed
                  color: Colors.grey[900], // Change color as needed
                  fontWeight: FontWeight.w800),
            ),
          ),

          // animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // temerature
          Container(
            margin: EdgeInsets.only(top: 16.0), // Adjust margin as needed
            child: Text(
              '${_weather?.temperature.round()}°C',
              style: TextStyle(
                  fontSize: 48.0, // Adjust font size as needed
                  color: Colors.grey[700], // Change color as needed
                  fontWeight: FontWeight.w800),
            ),
          ),

          // weather condition
          // Text(_weather?.mainCondition ?? "")
        ]),
      ),
    );
  }
}
