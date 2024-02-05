import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_services.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('e38c12d6fa7ba71e7cbc9f27b0dcf3cd');
  Weather? _weather;

  // Fetch weather
  Future<void> fetchWeather() async {
    try {
      // Get the current city
      String cityName = await _weatherService.getCurrentCity();

      // Get weather for the city
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // Default to sunny

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
        return 'assets/1.json';
      case 'thunderstorm':
        return 'assets/3.json';
      case 'clear':
        return 'assets/2.json';
      default:
        return 'assets/2.json'; // Change this line to whatever default animation you want
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City name
            Text(
              _weather?.cityName ?? "Loading city...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            // Animation

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // Temperature
            Text(
              '${_weather?.temperature?.round()}°C',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
