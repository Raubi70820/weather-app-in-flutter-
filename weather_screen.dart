import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'forecast_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  String _city = '';
  String _temperature = '';
  String _windSpeed = '';
  String _humidity = '';
  String _description = '';
  dynamic image;
  dynamic _icon;

  Future<void> _fetchWeather(String city) async {
    const apiKey = '1d46c910dfc3641371119b242d027a36';
    final weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final weatherResponse = await http.get(Uri.parse(weatherUrl));

    if (weatherResponse.statusCode == 200) {
      final weatherData = json.decode(weatherResponse.body);
      setState(() {
        _temperature = weatherData['main']['temp'].toString();
        _windSpeed = weatherData['wind']['speed'].toString();
        _humidity = weatherData['main']['humidity'].toString();
        _description = weatherData['weather'][0]['description'];
        _icon = _getWeatherIcon(_description);
        _city = city;
      });
    } else {
      setState(() {
        _temperature = 'Error fetching weather data';
      });
    }
  }

  // String _getWeatherIcon(String description) {
  //   switch (description.toLowerCase()) {
  //     case 'clear sky':
  //       return 'https://example.com/sunny.png'; // Sunny
  //     case 'few clouds':
  //       return 'https://example.com/partly_cloudy.png'; // Partly cloudy
  //     case 'scattered clouds':
  //     case 'broken clouds':
  //       return 'https://example.com/cloudy.png'; // Cloudy
  //     case 'shower rain':
  //     case 'rain':
  //       return 'https://example.com/rain.png'; // Rain
  //     case 'thunderstorm':
  //       return 'https://example.com/thunderstorm.png'; // Thunderstorm
  //     case 'snow':
  //       return 'https://example.com/snow.png'; // Snow
  //     case 'mist':
  //       return 'https://example.com/mist.png'; // Mist
  //     default:
  //       return 'https://example.com/default.png'; // Default weather icon
  //   }
  // }
  _getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'mist':
        //   icon = const Icon(WeatherIcons.day_fog);
        image = Image.asset('assets/weather/09n.png');
        break;
      case 'sunny':
        // icon = const Icon(WeatherIcons.day_sunny);
        image = Image.asset('assets/weather/01d.png');
        break;
      case 'clouds':
        // icon = const Icon(WeatherIcons.cloud);
        image = Image.asset('assets/weather/01n.png');
        break;
      // Partly cloudy
      case 'overcast clouds':
      case 'broken clouds':
        // icon = const Icon(WeatherIcons.cloud_down); // Cloudy
        image = Image.asset('assets/weather/01n.png');
        break;
      case 'light rain':
      case 'rain':
        // icon = const Icon(WeatherIcons.rain); // Rain
        image = Image.asset('assets/weather/10n.png');
        break;
      case 'thunderstorm':
        // icon = const Icon(WeatherIcons.day_thunderstorm); // Thunderstorm
        image = Image.asset('assets/weather/11d.png');
        break;
      case 'snow':
        // icon = const Icon(WeatherIcons.snow); // Snow
        image = Image.asset('assets/weather/13n.png');
        break;
      // case 'scattered clouds':
      //   icon = const Icon(WeatherIcons.night_cloudy); // Snow
      //   break;
      // case 'haze':
      //   icon = const Icon(WeatherIcons.day_haze); // Snow
      //   break;
      default:
        // icon = const Icon(WeatherIcons.celsius);
        image = Image.asset('assets/weather/09d.png');
    }

    return Container(
      width: 100.0, // Set the width of the container
      height: 100.0, // Set the height of the container
      decoration: BoxDecoration(
        color:
            const Color.fromARGB(255, 90, 5, 143), // Set the background color

        shape: BoxShape.circle, // Set the shape of the container
      ),
      child: Center(
        child: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// bottomNavigationBar: BottomNavigationBar(items:<BottomNavigationBarItem> [
//   BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',

//           ),
//             BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//             BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),

// fixedColor: Colors.amber,
// ),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 96, 97, 13),
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Enter city name',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white, fontSize: 18),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            _fetchWeather(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              _fetchWeather(_controller.text);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.amber,

        height: double.infinity,
        width: double.infinity,

        // decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://img.freepik.com/free-photo/top-view-grey-clouds-arrangement_23-2148964565.jpg?w=900&t=st=1722970838~exp=1722971438~hmac=dcae2b2411d28996346530a1006094de3391e1e4ca9f3fdad71a341345cf7f79'),
        //  fit: BoxFit.cover,)),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (_temperature.isNotEmpty)
                Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '$_city',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                              Text(
                                '$_temperature°c',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                              Text(
                                '$_description',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          _getWeatherIcon(_description),
                        ],
                      ),
                      // color: const Color.fromARGB(255, 91, 89, 96),
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 54, 102, 141)),
                      margin: EdgeInsets.all(5),
                    ),
                    // CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       _icon.isNotEmpty ? NetworkImage(_icon) : null,
                    //   backgroundColor: Colors.transparent,
                    // ),
                    SizedBox(width: 10),
                    SizedBox(height: 10),
                    // Text(
                    //   'Temperature: $_temperature°C',
                    //   style: TextStyle(fontSize: 24),
                    // ),
                    Container(
                      width: double.infinity,
                      color: const Color.fromARGB(255, 7, 255, 44),
                      height: 100,
                      child: Center(
                        child: Text(
                          'Wind Speed: $_windSpeed m/s',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 100,
                      color: const Color.fromARGB(255, 0, 14, 95),
                      child: Center(
                        child: Text(
                          'Humidity: $_humidity%',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    // Text(
                    //   'Condition: $_description',
                    //   style: TextStyle(fontSize: 24),
                    // ),
                    //  _getWeatherIcon(_description),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 100,
                      
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForecastScreen(city: _city),
                              
                            ),
                          );
                        },
                        child: Text('Show Weekly Forecast'),
                        
                        
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
