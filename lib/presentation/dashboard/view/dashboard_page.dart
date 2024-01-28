import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/app_bottom_bar.dart';
import 'package:coffee_challenge/core/helper/assets_path.dart';
import 'package:coffee_challenge/presentation/cart/view/cart_page.dart';
import 'package:coffee_challenge/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:coffee_challenge/presentation/dashboard/pages/notification_page.dart';
import 'package:coffee_challenge/presentation/favorites/view/favorites_page.dart';
import 'package:coffee_challenge/presentation/home/view/home_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const iconHeight = 28.0;
    return Scaffold(
      body: BlocBuilder<DashboardCubit, BottomNavBarItem>(
        builder: (context, currentTab) {
          switch (currentTab) {
            case BottomNavBarItem.home:
              return const HomePage();
            case BottomNavBarItem.favorites:
              return  FavoritesPage();
            case BottomNavBarItem.cart:
              return const CartPage();
            case BottomNavBarItem.notification:
              return const NotificationPage();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<DashboardCubit, BottomNavBarItem>(
        builder: (context, currentTab) {
          return FlashyTabBar(
            selectedIndex: currentTab.index,
            onItemSelected: (index) {
              final selectedTab = BottomNavBarItem.values[index];
              context.read<DashboardCubit>().updateTab(selectedTab);
            },
            items: [
              FlashyTabBarItem(
                selectedIcon: Image.asset(
                  AssetsPath.homeBrownIcon,
                  height: iconHeight,
                ),
                unSelectedIcon: Image.asset(
                  AssetsPath.homeIcon,
                  height: iconHeight,
                ),
              ),
              FlashyTabBarItem(
                selectedIcon: Image.asset(
                  AssetsPath.heartBrownIcon,
                  height: iconHeight,
                ),
                unSelectedIcon: Image.asset(
                  AssetsPath.heartIcon,
                  height: iconHeight,
                ),
              ),
              FlashyTabBarItem(
                selectedIcon: Image.asset(
                  AssetsPath.bagBrownIcon,
                  height: iconHeight,
                ),
                unSelectedIcon: Image.asset(
                  AssetsPath.bagIcon,
                  height: iconHeight,
                ),
              ),
              FlashyTabBarItem(
                selectedIcon: Image.asset(
                  AssetsPath.bellBrownIcon,
                  height: iconHeight,
                ),
                unSelectedIcon: Image.asset(
                  AssetsPath.bellIcon,
                  height: iconHeight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
