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
              onPressed: () {},
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
