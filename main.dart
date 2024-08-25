

import 'package:flutter/material.dart';
import 'package:flutter_weathear_app/weather_screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:WeatherScreen() ,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_weathear_app/consts/images.dart';

// // import 'package:flutter_weathear_app/services/api_services.dart';
// // import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:weather_icons/weather_icons.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WeatherScreen(),
     
//     );
//   }
// }

//  //31 /07/24

// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   final TextEditingController _controller = TextEditingController();
//   String _city = '';
//   String _temperature = '';
//   String _windSpeed = '';
//   String _humidity = '';
//   String _description = '';
//   var _icon = '';
//   dynamic image;
//   List<String> _forecast = [];

//   Future<void> _fetchWeather(String city) async {
//     final apiKey = '1d46c910dfc3641371119b242d027a36';
//     final weatherUrl =
//         'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
//     final forecastUrl =
//         'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

//     final weatherResponse = await http.get(Uri.parse(weatherUrl));
//     final forecastResponse = await http.get(Uri.parse(forecastUrl));

//     if (weatherResponse.statusCode == 200) {
//       final weatherData = json.decode(weatherResponse.body);
//       setState(() {
//         _temperature = weatherData['main']['temp'].toString();
//         _windSpeed = weatherData['wind']['speed'].toString();
//         _humidity = weatherData['main']['humidity'].toString();
//         _description = weatherData['weather'][0]['description'];
//         dynamic _icon = _getWeatherIcon(weatherData['weather'][0]['icon']);
//         _city = city;
//       });
//     } else {
//       setState(() {
//         _temperature = 'Error fetching weather data';
//       });
//     }

//     if (forecastResponse.statusCode == 200) {
//       final forecastData = json.decode(forecastResponse.body);
//       setState(() {
//         _forecast = [];
//         for (var i = 0; i < forecastData['list'].length; i += 8) {
//           final item = forecastData['list'][i];
//           final dateTime = DateTime.parse(item['dt_txt']);
//           final dayName = DateFormat('EEEE').format(dateTime);
//           final temp = item['main']['temp'].toString();
//           final description = item['weather'][0]['description'];
//           _forecast.add('$dayName - $temp°C - $description $humidity');
//         }
//       });
//     } else {
//       setState(() {
//         _forecast = ['Error fetching forecast data'];
//       });
//     }
//   }


//   _getWeatherIcon(String description) {
//     Icon icon;
//     switch (description.toLowerCase()) {
//       case 'mist':
//       //   icon = const Icon(WeatherIcons.day_fog);
//      image=  Image.asset('assets/weather/01n.png');
//         break;
//       case 'sunny':
//         // icon = const Icon(WeatherIcons.day_sunny);
//         image= Image.asset('assets/weather/012d.png');
//         break;
//       case 'clouds':
//         // icon = const Icon(WeatherIcons.cloud);
//       image=   Image.asset('assets/weather/03d.png');
//         break;
//       // Partly cloudy
//       case 'overcast clouds':
//       case 'broken clouds':
//         // icon = const Icon(WeatherIcons.cloud_down); // Cloudy
//        image= Image.asset('assets/weather/01d.png');
//         break;
//       case 'light rain':
//       case 'rain':
//         // icon = const Icon(WeatherIcons.rain); // Rain
//     image=     Image.asset('assets/weather/04d.png');
//         break;
//       case 'thunderstorm':
//         // icon = const Icon(WeatherIcons.day_thunderstorm); // Thunderstorm
//       image=   Image.asset('assets/weather/09d.png');
//         break;
//       case 'snow':
//         // icon = const Icon(WeatherIcons.snow); // Snow
//        image=  Image.asset('assets/weather/10.png');
//         break;
//       case 'scattered clouds':
//         icon = const Icon(WeatherIcons.night_cloudy); // Snow
//         break;
//       case 'haze':
//         icon = const Icon(WeatherIcons.day_haze); // Snow
//         break;
//       default:
//         icon = const Icon(WeatherIcons.celsius);
//     }

//     return Container(
//       width: 100.0, // Set the width of the container
//       height: 100.0, // Set the height of the container
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255), // Set the background color

//         shape: BoxShape.circle, // Set the shape of the container
//       ),
//       child: Center(
//         child: image,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: 'Enter city name',
//               border: InputBorder.none,
//               hintStyle: TextStyle(color: Colors.white),
//             ),
//             style: TextStyle(color: Colors.white, fontSize: 18),
//             textInputAction: TextInputAction.search,
//             onSubmitted: (value) {
//               _fetchWeather(value);
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 _fetchWeather(_controller.text);
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               if (_temperature.isNotEmpty)
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           foregroundColor: Colors.red,
//                           radius: 30,
//                           backgroundImage:
//                               _icon.isNotEmpty ? NetworkImage(_icon) : null,
//                           backgroundColor: const Color.fromARGB(0, 0, 0, 0),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 10),
//                     Text(
//                       ' $_city: $_temperature°C',
//                       style: TextStyle(fontSize: 24),
//                     ),
//                     Container(
//                         color: Colors.amber,
//                         height: 50,
//                         width: double.infinity,
//                         margin: EdgeInsets.all(20),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/windspeed.png',
//                               width: 40,
//                             ),
//                             Text(
//                               'Wind Speed: $_windSpeed m/s',
//                               style: TextStyle(fontSize: 24),
//                             ),
//                           ],
//                         )),

//                     Container(
//                         color: Colors.amber,
//                         height: 50,
//                         width: double.infinity,
//                         margin: EdgeInsets.all(20),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/humidity.png',
//                               width: 40,
//                             ),
//                             Text(
//                               'Humidity: $_humidity%',
//                               style: TextStyle(fontSize: 24),
//                             )
//                           ],
//                         )),
                   

//                     Text(
//                       'condition: $_description',
//                       style: TextStyle(fontSize: 24),
//                     ),
//                     _getWeatherIcon(_description),

                   
                    
//                     if (_forecast.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Weather Forecast:',
//                           style: TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         for (var forecast in _forecast)
//                           Text(
//                             forecast,
//                             style: TextStyle(fontSize: 18),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ));
//   }
// }
