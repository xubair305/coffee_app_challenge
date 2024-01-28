part of 'order_track_cubit.dart';

@immutable
sealed class OrderTrackState {}

final class OrderTrackInitial extends OrderTrackState {}

final class GMapLoading extends OrderTrackState {}

final class GMapLoaded extends OrderTrackState {
  GMapLoaded({required this.cameraPosition});
  final CameraPosition cameraPosition;
}
