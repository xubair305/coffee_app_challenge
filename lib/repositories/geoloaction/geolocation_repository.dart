import 'dart:convert';
import 'dart:developer';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/model/directions_model.dart';
import 'package:coffee_challenge/repositories/geoloaction/base_geoloaction_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GeolocationRepository extends BaseGeolocationRepository {
  @override
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied.',
      );
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Future<Directions?> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final googleMapKey = dotenv.get('GOOGLE_MAP_KEY');

    final queryParam = {
      'destination':
          'side_of_road:${destination.latitude},${destination.longitude}',
      'origin': '${origin.latitude},${origin.longitude}',
      'key': googleMapKey,
    };

    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/directions/json',
      queryParam,
    );
    try {
      final response =
          await http.get(uri, headers: {'content-type': 'application/json'});
      final responseBody = utf8.decoder.convert(response.bodyBytes);

      if (response.statusCode == 200) {
        final direc = Directions.fromMap(
          json.decode(responseBody) as Map<String, dynamic>,
        );
        log('Success in Google Map Search Places Response Calling $direc');
        return direc;
      } else {
        log('Failure in Google Map Search Places Response Calling');
        return null;
      }
    } catch (e) {
      log('Google Map Search Places Response Exception :  $e');
      return null;
    }
  }

  @override
  Polyline getPolyline(Directions? direction) {
    return Polyline(
      polylineId: const PolylineId('coffee_polyline'),
      color: AppColors.appBrown,
      points: direction!.polylinePoint
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList(),
      width: 4,
      endCap: Cap.roundCap,
      geodesic: true,
      zIndex: 1,
    );
  }
}
