class Weather {
  final Location location;
  final Current current;
  final Forecast forecast;

  Weather(
      {required this.location, required this.current, required this.forecast});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Location {
  final String name;

  Location({required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json['name']);
  }
}

class Current {
  final double tempC;
  final Condition condition;

  Current({required this.tempC, required this.condition});

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Condition {
  final String text;

  Condition({required this.text});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(text: json['text']);
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecastday'] as List;
    List<ForecastDay> forecastDayList =
        list.map((i) => ForecastDay.fromJson(i)).toList();
    return Forecast(forecastday: forecastDayList);
  }
}

class ForecastDay {
  final String date;
  final Day day;

  ForecastDay({required this.date, required this.day});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      day: Day.fromJson(json['day']),
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final Condition condition;

  Day(
      {required this.maxtempC,
      required this.mintempC,
      required this.condition});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'],
      mintempC: json['mintemp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}
