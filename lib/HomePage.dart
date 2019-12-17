import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_get/Map.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      // appBar: AppBar(
      //   //title: Text("Weather Get"),
      //   backgroundColor: Colors.redAccent,
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/cover7.jpg'),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.7),
                ),
                height: 90,
                width: 300,
                margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.only(top: 15),
                child: Text('Weather Get',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.7),
                ),

                // height: 10,
                width: 350,
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(20),
                child: Text(
                  'Get this app on your smartphone, and you will be able to stay on top of weather conditions in your immediate area or anywhere else in the world.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                height: 60,
                width: 270,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MapView(),
                      ),
                    );
                  },
                  color: Colors.blueAccent,
                  child: Text(
                    'Select Location',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
