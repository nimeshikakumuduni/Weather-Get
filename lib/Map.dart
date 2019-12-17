import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_get/ViewDetails.dart';

class MapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapViewState();
  }
}

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];
  static final CameraPosition _sriLanka = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    zoom: 9.4746,
  );

  LatLng selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Select Location'),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _sriLanka,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng latLang) {
            print(latLang);
            selectedLocation = latLang;
            setState(() {
              markers = [];
              markers.add(
                Marker(
                  markerId: MarkerId('Selected Location'),
                  position: latLang,
                  infoWindow: InfoWindow(title: "Selected Location"),
                ),
              );
            });
          },
          markers: Set<Marker>.of(markers),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ViewDetails(selectedLocation),
            ),
          );
        },
      ),
    );
  }
}
