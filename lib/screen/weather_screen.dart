import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
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
              print("refresh");
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),

      //futurebuilder is handy eh fetchinf data
      body: FutureBuilder(
        future: getCurrentWeather(),
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
          final currentTemp = data['list'][0]['main']['temp'];

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
                                  const Icon(
                                    Icons.cloud,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    "Rain",
                                    style: TextStyle(fontSize: 20),
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
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ForeCastCard(
                          exactTemp: "301.7",
                          theIcon: Icon(
                            Icons.sunny,
                            size: 32,
                          ),
                          time: "3:00",
                        ),
                        ForeCastCard(
                          exactTemp: "200.7",
                          theIcon: Icon(
                            Icons.thunderstorm,
                            size: 32,
                          ),
                          time: "4:00",
                        ),
                        ForeCastCard(
                          exactTemp: "160.7",
                          theIcon: Icon(
                            Icons.cloud,
                            size: 32,
                          ),
                          time: "4:30",
                        ),
                        ForeCastCard(
                          exactTemp: "701.7",
                          theIcon: Icon(
                            Icons.cloud,
                            size: 32,
                          ),
                          time: "6:00",
                        ),
                        ForeCastCard(
                          exactTemp: "401.7",
                          theIcon: Icon(
                            Icons.cloud,
                            size: 32,
                          ),
                          time: "8:00",
                        ),
                      ],
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

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoCard(
                        title: "Humidity",
                        theIcon: Icon(
                          Icons.water_drop,
                          size: 30,
                        ),
                        numberData: 94,
                      ),
                      AdditionalInfoCard(
                        title: "Wind Speed",
                        theIcon: Icon(
                          Icons.air,
                          size: 30,
                        ),
                        numberData: 7.67,
                      ),
                      AdditionalInfoCard(
                        title: "Pressure",
                        theIcon: Icon(
                          Icons.beach_access,
                          size: 30,
                        ),
                        numberData: 1006,
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
