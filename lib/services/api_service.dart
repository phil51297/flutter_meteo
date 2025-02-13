import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meteo_flutter/models/weather.dart';

class ApiService {
  final String apiUrl =
      'http://api.weatherapi.com/v1/forecast.json?key=074c22fd8dfd416cb85104927251102';

  Future<Weather> getData(String city, int days) async {
    final response = await http.get(Uri.parse('$apiUrl&q=$city&days=$days'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
