import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/presentation/order_track/cubit/order_track_cubit.dart';
import 'package:coffee_challenge/presentation/order_track/widgets/bottom_info_box.dart';
import 'package:coffee_challenge/presentation/order_track/widgets/map_widget.dart';
import 'package:coffee_challenge/repositories/geoloaction/geolocation_repository.dart';

class OrderTrackPage extends StatelessWidget {
  const OrderTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GeolocationRepository(),
      child: BlocProvider(
        create: (context) => OrderTrackCubit(
          geolocationRepository: context.read<GeolocationRepository>(),
        )..initMapController(),
        child: const OrderTrack(),
      ),
    );
  }
}

class OrderTrack extends StatefulWidget {
  const OrderTrack({super.key});

  @override
  State<OrderTrack> createState() => _OrderTrackState();
}

class _OrderTrackState extends State<OrderTrack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: const Stack(
        children: [
          MapWidget(),
          BottomInfoBox(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 86,
      leading: Bouncing(
        onTap: () => context.pop(),
        child: Container(
          margin: const EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      actions: [
        Bouncing(
          onTap: () => context.read<OrderTrackCubit>().getCurrentLocation(),
          child: Container(
            height: context.height,
            width: 56,
            margin: const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Icon(Icons.my_location_rounded),
          ),
        ),
      ],
    );
  }
}
