import 'package:flutter/material.dart';
import 'package:meteo_flutter/models/weather.dart';
import 'package:meteo_flutter/services/api_service.dart';

class WeatherProvider with ChangeNotifier {
  final ApiService apiService;
  Weather? weather;
  String city = '';
  bool isLoading = false;
  String errorMessage = '';

  WeatherProvider({required this.apiService});

  Future<void> fetchWeather(String city, int days) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      weather = await apiService.getData(city, days);
      this.city = city;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
