import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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
  var responseData;
  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network('http://openweathermap.org/img/w/03n.png'),
                  ),
                  Text(responseData.toString())
                ],
              ),
            ),
      ),
    );
  }

  getWeatherData() {
    http.get('https://api.openweathermap.org/data/2.5/weather?lat=' +
        widget.selectedLocation.latitude.toString() +
        '&lon=' +
        widget.selectedLocation.longitude.toString() +
        '&appid=098cfb42f8e908f3a640e24b102de176').then((http.Response response){
          setState(() {
            isLoading = false;
          });
          responseData = response.body;
          print(response.body);
        });
  }
}
