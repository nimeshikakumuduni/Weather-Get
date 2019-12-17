import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_get/WeatherData.dart';
import 'package:country_code_picker/country_code_picker.dart';

class ViewDetails extends StatefulWidget {
  final LatLng selectedLocation;

  ViewDetails(this.selectedLocation);
  @override
  State<StatefulWidget> createState() {
    return ViewDetailsState();
  }
}

class ViewDetailsState extends State<ViewDetails> {
  bool isLoading = true;
  WeatherData responseData;
  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Data"),
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cover7.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.5)),
                        child: Text(
                          responseData.name + ', ' + responseData.sys.country,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Image.network(
                          'http://openweathermap.org/img/w/' +
                              responseData.weather[0].icon +
                              '.png',
                          scale: 0.5,
                        ),
                      ),
                      Text(
                        responseData.weather[0].description,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 100,
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      toCelsius(responseData.main.tempMin),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ), 
                                    Text('Min')
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      toCelsius(responseData.main.tempMax),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ), 
                                    Text('Max')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  getWeatherData() {
    http
        .get('https://api.openweathermap.org/data/2.5/weather?lat=' +
            widget.selectedLocation.latitude.toString() +
            '&lon=' +
            widget.selectedLocation.longitude.toString() +
            '&appid=098cfb42f8e908f3a640e24b102de176')
        .then((http.Response response) {
      setState(() {
        isLoading = false;
      });
      responseData = WeatherData.fromJson(json.decode(response.body));
      print(responseData.weather[0].description);
    });
  }

  toCelsius(double kelivin) {
    return (kelivin - 273.15).toStringAsFixed(1) + " \u2103";
  }


}
