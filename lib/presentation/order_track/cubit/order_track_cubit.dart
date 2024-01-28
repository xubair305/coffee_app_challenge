import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_challenge/core/helper/const_methods.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/core/utils/app_logger.dart';
import 'package:coffee_challenge/repositories/geoloaction/geolocation_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'order_track_state.dart';

class OrderTrackCubit extends Cubit<OrderTrackState> {
  OrderTrackCubit({required GeolocationRepository geolocationRepository})
      : _geolocationRepository = geolocationRepository,
        super(OrderTrackInitial());

  final GeolocationRepository _geolocationRepository;
  final _mapCompleter = Completer<GoogleMapController>();

  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  Future<void> getCurrentLocation() async {
    final position = await _geolocationRepository.getCurrentLocation();

    if (position != null) {
      final myCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
      final controller = await _mapCompleter.future;
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(myCameraPosition));
    }
  }

  Future<void> initMapController() async {
    emit(GMapLoading());
    const kLake = CameraPosition(
      target: LatLng(28.610719, 77.109561),
      zoom: 17,
    );
    await getPolylineRoute();
    emit(GMapLoaded(cameraPosition: kLake));
  }

  void onGMapCreated(GoogleMapController controller) {
    if (!_mapCompleter.isCompleted) {
      _mapCompleter.complete(controller);
    }
  }

  Future<void> getPolylineRoute() async {
    const latLng = LatLng(28.6109036, 77.1082701);
    const latLng2 = LatLng(28.6109997, 77.1112811);
    final direction = await _geolocationRepository.getDirection(
      origin: latLng,
      destination: latLng2,
    );

    final polyline = _geolocationRepository.getPolyline(direction);
    polylines.add(polyline);

    final markerImg = await Future.wait([
      ConstMethods.getBytesFromAsset(AssetsPath.scooterMarker, 100),
      ConstMethods.getBytesFromAsset(AssetsPath.pinMarker, 100),
    ]);

    final marker = [
      Marker(
        markerId: const MarkerId('scooter_marker'),
        icon: BitmapDescriptor.fromBytes(markerImg[0]),
        position: latLng2,
        flat: true,
      ),
      Marker(
        markerId: const MarkerId('pin_marker'),
        icon: BitmapDescriptor.fromBytes(markerImg[1]),
        position: latLng,
        flat: true,
      ),
    ];

    markers.addAll(marker);
  }

  @override
  Future<void> close() {
    logger.i('Close Called');
    return super.close();
  }
}
