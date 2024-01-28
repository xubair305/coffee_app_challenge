import 'package:coffee_challenge/app/router/routes_path.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/presentation/coffee_details/view/coffee_details_page.dart';
import 'package:coffee_challenge/presentation/dashboard/view/dashboard_page.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:coffee_challenge/presentation/home/view/home_page.dart';
import 'package:coffee_challenge/presentation/order_checkout/view/order_checkout_page.dart';
import 'package:coffee_challenge/presentation/order_track/view/order_track_page.dart';
import 'package:coffee_challenge/presentation/search/view/search_page.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: Routes.dashboardPath,
  observers: [HeroController()],

  // debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: Routes.homeName,
      path: Routes.homePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: Routes.dashboardName,
      path: Routes.dashboardPath,
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      name: Routes.coffeeDetailsName,
      path: Routes.coffeeDetailsPath,
      builder: (context, state) =>
          CoffeeDetailsPage(coffeeItem: state.extra as CoffeeItem?),
    ),
    GoRoute(
      name: Routes.orderCheckoutName,
      path: Routes.orderCheckoutPath,
      builder: (context, state) =>
          OrderCheckoutPage(coffeeItem: state.extra as CoffeeItem?),
    ),
    GoRoute(
      name: Routes.orderTrackName,
      path: Routes.orderTrackPath,
      builder: (context, state) => const OrderTrackPage(),
    ),
    GoRoute(
      name: Routes.searchName,
      path: Routes.searchPath,
      builder: (context, state) => const SearchPage(),
    ),
  ],
  errorBuilder: (context, state) => Center(
    child: Text(state.error.toString()),
  ),
);
