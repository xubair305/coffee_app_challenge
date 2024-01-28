import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  Directions({
    required this.bounds,
    required this.polylinePoint,
  });
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoint;

  static Directions? fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return null;

    final data =
        Map<String, dynamic>.from(map['routes'][0] as Map<String, dynamic>);

    // bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final encodedPoint = data['overview_polyline']['points'].toString();
    final bounds = LatLngBounds(
      southwest: LatLng(southwest['lat'] as double, southwest['lng'] as double),
      northeast: LatLng(northeast['lat'] as double, northeast['lng'] as double),
    );

    return Directions(
      bounds: bounds,
      polylinePoint: PolylinePoints().decodePolyline(encodedPoint),
    );
  }
}
