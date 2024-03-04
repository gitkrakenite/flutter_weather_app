import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/component/additional_info_card.dart';
import 'package:weather_app/component/forecast_card.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class MyWeatherApp extends StatefulWidget {
  const MyWeatherApp({super.key});

  @override
  State<MyWeatherApp> createState() => _MyWeatherAppState();
}

class _MyWeatherAppState extends State<MyWeatherApp> {
  // create a function to fetch data
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Nairobi";
      final response = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey"),
      );
      final data = jsonDecode(response.body);

      //handle error
      if (data['cod'] != "200") {
        throw "An Error occurred";
      }

      return data; //succesful call
    } catch (e) {
      throw e.toString();
    }
  }

  //now we need to call the function
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {}); //refresh the UI
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),

      //futurebuilder is handy eh fetchinf data
      body: FutureBuilder(
        future: getCurrentWeather(), //remember we returned data
        builder: (context, snapshot) {
          // handle loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(), //load based on OS
            );
          }

          //handle error when fetching
          if (snapshot.hasError) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }

          //handle data we get from the server

          final data = snapshot.data!; //can be nullable

          //retrieving data from data and storing in variables
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp']; //the big card
          final currentWeather =
              currentWeatherData['weather'][0]['main']; //cloudy

          //additional info variable
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];

          //weather forecast variables

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //main card
                  SizedBox(
                    width: double.maxFinite, //full width
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    "$currentTemp K",
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  //implementing a heavy ternary operator
                                  Icon(
                                    currentWeather == "Clouds"
                                        ? Icons.cloud
                                        : currentWeather == "Clear"
                                            ? Icons.sunny
                                            : Icons.thunderstorm,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    currentWeather.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),

                  // weather forecast
                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  //it is very bad practice to load 30 widgets at the same time especially when fetching data we need to do lazy loading hence the listview.builder

                  //listview  has a tendecy to take entire screen. we need to fix it
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final hourlyForeCast = data['list'][index + 1];
                        final time = DateTime.parse(hourlyForeCast['dt_txt']);
                        return ForeCastCard(
                          exactTemp: hourlyForeCast['main']['temp'].toString(),
                          theIcon: Icon(
                            hourlyForeCast['weather'][0]['main'] == 'Clouds'
                                ? Icons.cloud
                                : hourlyForeCast['weather'][0]['main'] == 'Rain'
                                    ? Icons.thunderstorm
                                    : Icons.sunny,
                            size: 32,
                          ),
                          time: DateFormat.j().format(time), //readable time
                        );
                      },
                    ),
                  ),

                  // additional information
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoCard(
                        title: "Humidity",
                        theIcon: const Icon(
                          Icons.water_drop,
                          size: 30,
                        ),
                        numberData: currentHumidity.toString(),
                      ),
                      AdditionalInfoCard(
                        title: "Wind Speed",
                        theIcon: const Icon(
                          Icons.air,
                          size: 30,
                        ),
                        numberData: currentWindSpeed.toString(),
                      ),
                      AdditionalInfoCard(
                        title: "Pressure",
                        theIcon: const Icon(
                          Icons.beach_access,
                          size: 30,
                        ),
                        numberData:
                            currentPressure.toString(), //convert to string
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
