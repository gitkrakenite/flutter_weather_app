import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/component/additional_info_card.dart';
import 'package:weather_app/component/forecast_card.dart';

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({super.key});

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
      body: Padding(
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
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "303.67 ° Knot",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Icon(
                              Icons.cloud,
                              size: 70,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Rain",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                    ForeCastCard(),
                    ForeCastCard(),
                    ForeCastCard(),
                    ForeCastCard(),
                    ForeCastCard(),
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
                      numberData: 94),
                  AdditionalInfoCard(
                      title: "Wind Speed",
                      theIcon: Icon(
                        Icons.wind_power,
                        size: 30,
                      ),
                      numberData: 7.67),
                  AdditionalInfoCard(
                      title: "Pressure",
                      theIcon: Icon(
                        Icons.umbrella,
                        size: 30,
                      ),
                      numberData: 1006),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
