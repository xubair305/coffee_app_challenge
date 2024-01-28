import 'package:bloc/bloc.dart';

enum BottomNavBarItem { home, favorites, cart, notification }

class DashboardCubit extends Cubit<BottomNavBarItem> {
  DashboardCubit() : super(BottomNavBarItem.home);

  void updateTab(BottomNavBarItem tab) => emit(tab);
}
