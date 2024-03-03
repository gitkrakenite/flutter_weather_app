import 'package:flutter/material.dart';
import 'package:weather_app/screen/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false, //remove the top-right
      home: const MyWeatherApp(),
    );
  }
}
