import 'package:flutter/material.dart';
import 'package:meteo_flutter/providers/weather_provider.dart';
import 'package:meteo_flutter/services/api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        home: WeatherApp(),
      ),
    );
  }
}

class WeatherApp extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController daysController = TextEditingController(text: '3');

  WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Meteo Flutter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Enter city'),
            ),
            TextField(
              controller: daysController,
              decoration: InputDecoration(labelText: 'Enter days'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;
                final days = int.tryParse(daysController.text) ?? 3;
                weatherProvider.fetchWeather(city, days);
              },
              child: Text('Search'),
            ),
            if (weatherProvider.isLoading) CircularProgressIndicator(),
            if (weatherProvider.errorMessage.isNotEmpty)
              Text(weatherProvider.errorMessage,
                  style: TextStyle(color: Colors.red)),
            if (weatherProvider.weather != null) ...[
              Text('City: ${weatherProvider.city}',
                  style: TextStyle(fontSize: 24)),
              Text(
                  'Current Temperature: ${weatherProvider.weather!.current.tempC}°C',
                  style: TextStyle(fontSize: 16)),
              Text(
                  'Current Condition: ${weatherProvider.weather!.current.condition.text}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('Forecast:', style: TextStyle(fontSize: 20)),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      weatherProvider.weather!.forecast.forecastday.length,
                  itemBuilder: (context, index) {
                    final day =
                        weatherProvider.weather!.forecast.forecastday[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${day.date}',
                                style: TextStyle(fontSize: 16)),
                            Text('Max Temperature: ${day.day.maxtempC}°C',
                                style: TextStyle(fontSize: 16)),
                            Text('Min Temperature: ${day.day.mintempC}°C',
                                style: TextStyle(fontSize: 16)),
                            Text('Condition: ${day.day.condition.text}',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
