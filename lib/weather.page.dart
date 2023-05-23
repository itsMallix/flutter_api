import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_api/weather.dart';
import 'package:flutter_api/weather.service.dart';
import 'package:http/http.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[850]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_circle),
              SizedBox(width: 10),
              Text(
                'Weather App',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ],
          ),
        ),
        body: const MyAppContent(),
      ),
    );
  }
}

class MyAppContent extends StatefulWidget {
  const MyAppContent({Key? key}) : super(key: key);

  @override
  State<MyAppContent> createState() => _MyAppContentState();
}

class _MyAppContentState extends State<MyAppContent> {
  TextEditingController controller = TextEditingController();
  dataService _dataService = dataService();
  Weather weather = Weather();
  bool isFetch = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isFetch
              ? Column(
                  children: [
                    Image.network(
                        'https://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                    Text('${weather.temp}°',
                        style: Theme.of(context).textTheme.headlineLarge),
                    Text(weather.description,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                )
              : SizedBox(),
          Container(
            width: screenWidth * 0.7,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'City',
                labelStyle: TextStyle(
                  color: (Color(0xFF424242)),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              isFetch = true;
              weather = await _dataService.fetchData(controller.text);
              setState(() {});
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade800),
            ),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
