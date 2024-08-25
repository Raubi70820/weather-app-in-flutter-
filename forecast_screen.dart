import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ForecastScreen extends StatefulWidget {
  final String city;

  ForecastScreen({required this.city});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<String> _forecast = [];
  // final streamController = StreamController<List<dynamic>>();

  

  @override
  void initState() {
    super.initState();
    _fetchForecast(widget.city);
  } 

  Future<void> _fetchForecast(String city) async {
    const apiKey = '1d46c910dfc3641371119b242d027a36';
    final forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

    final forecastResponse = await http.get(Uri.parse(forecastUrl));

    if (forecastResponse.statusCode == 200) {
      final forecastData = json.decode(forecastResponse.body);
      setState(() {
        _forecast = [];
        for (var i = 0; i < forecastData['list'].length; i += 8) {
          final item = forecastData['list'][i];
          final dateTime = DateTime.parse(item['dt_txt']);
          // DateTime now = DateTime.now();
          final dayName = DateFormat('EEEE').format(dateTime);
          // String dayName = DateFormat('EEE').format(dayName as DateTime);
          final temp = item['main']['temp'].toString();
          final description = item['weather'][0]['description'];
          _forecast.add('$dayName - $temp°C - $description');
        }
      });
    } else {
      setState(() {
        _forecast = ['Error fetching forecast data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 80, 92, 198),
        title: Text('Weekly Forecast for ${widget.city}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_forecast.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Forecast:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  for (var forecast in _forecast)
                    Center(
                      
                    
                      
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 90,
                        width: double.infinity,
                        child: Card(
                          
                          shadowColor: Colors.blueAccent,
                          
                          color: const Color.fromARGB(255, 182, 159, 77),
                          
                          
                          child: Center(
                            child: Text(
                              forecast,
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
