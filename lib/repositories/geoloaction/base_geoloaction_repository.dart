import 'package:coffee_challenge/model/directions_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BaseGeolocationRepository {
  Future<Position?> getCurrentLocation();
  Future<Directions?> getDirection({
    required LatLng origin,
    required LatLng destination,
  });

  Polyline getPolyline(Directions? direction);
}
