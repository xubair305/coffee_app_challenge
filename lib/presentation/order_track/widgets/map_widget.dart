import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/l10n/l10n.dart';
import 'package:coffee_challenge/presentation/order_track/cubit/order_track_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderTrackCubit, OrderTrackState>(
      builder: (context, state) {
        return SizedBox(
          height: context.height * 0.72,
          child: state is GMapLoading
              ? const Center(child: CircularProgressIndicator())
              : state is GMapLoaded
                  ? GoogleMap(
                      mapType: MapType.terrain,
                      polylines: context.read<OrderTrackCubit>().polylines,
                      markers: context.read<OrderTrackCubit>().markers,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: state.cameraPosition,
                      onMapCreated: (controller) => context
                          .read<OrderTrackCubit>()
                          .onGMapCreated(controller),
                    )
                  : Center(child: CustomText(context.l10n.somethingWrong)),
        );
      },
    );
  }
}
