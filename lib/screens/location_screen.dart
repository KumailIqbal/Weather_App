import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LocationScreen({this.locationData});
  // ignore: prefer_typing_uninitialized_variables
  final locationData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late String city;
  late String desc;
  late String cityName;
  late int temperature;
  late double windSpeed;
  late int humidity;
  late String icon;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        desc = 'error';
        cityName = '';
        temperature = 0;
        windSpeed = 0;
        humidity = 0;
        icon = '50d';
        return;
      }
      desc = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      windSpeed = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];
      icon = weatherData['weather'][0]['icon'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    var cityWeather = await weather.getCityWeather(city);
                    updateUI(cityWeather);
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 40,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter City Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        city = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              // ignore: sort_child_properties_last
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Image.network(
                      'http://openweathermap.org/img/w/$icon.png',
                      scale: 0.5,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          desc.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'in $cityName'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade800,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      WeatherIcons.thermometer,
                      size: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$temperature°',
                          style: const TextStyle(fontSize: 90),
                        ),
                        const Text(
                          ' C',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade800,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                WeatherIcons.day_windy,
                                size: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$windSpeed',
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'km/hr',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade800,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                WeatherIcons.humidity,
                                size: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$humidity',
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Percent',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
