import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:trust_location/trust_location.dart';

import 'package:location_permissions/location_permissions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _latitude;
  String? _longitude;
  bool? _isMockLocation;

  /// inicializar estado
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    TrustLocation.start(5);
    getLocation();
  }

  /// try catch para el metodo de obtener localizacion
  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => setState(() {
            _latitude = values.latitude;
            _longitude = values.longitude;
            _isMockLocation = values.isMockLocation;
          }));
    } on PlatformException catch (e) {
      print('PlatformException $e');
    }
  }

  /// permisos de localizacion
  void requestLocationPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    print('permissions: $permission');
  }

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Detector de GPS falso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Es un GPS falso: $_isMockLocation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}