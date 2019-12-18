import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_get/WeatherData.dart';

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
        title: Text("Weather Details"),
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
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.3), BlendMode.lighten)),
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
                          responseData.name == null
                              ? ''
                              : responseData.name +
                                  ', ' +
                                  responseData.sys.country,
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
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            Container(
                              height: 120,
                              width: 120,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                      style: BorderStyle.solid)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    toCelsius(responseData.main.temp),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                      displayDetail(
                        'Pressure',
                        getHgMm(responseData.main.pressure),
                      ),
                      displayDetail(
                        'Humidity',
                        '92%',
                      ),
                      displayDetail(
                        'Wind Speed',
                        responseData.wind.speed.toString() + ' m/s',
                      ),
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

  displayDetail(String attribute, String value) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.5)),
      child: Text(
        attribute + '  :  ' + value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  getHgMm(int pascal) {
    return (pascal * 0.00750062).toStringAsFixed(2) + " mmHg";
  }
}
