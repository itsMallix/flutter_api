import 'dart:convert';
import 'package:flutter_api/weather.dart';
import 'package:http/http.dart' as http;

class dataService {
  Future<Weather> fetchData(String cityName) async {
    try {
      //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
      final queryParams = {
        'q': cityName,
        'appid': '086bc073b93959429439a727ff1d4dff',
        'units': 'imperial',
      };
      final uri =
          Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParams);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Something wrong');
      }
    } catch (e) {
      rethrow;
    }
  }
}
