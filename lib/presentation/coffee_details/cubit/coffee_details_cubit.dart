import 'package:bloc/bloc.dart';
import 'package:coffee_challenge/core/utils/app_logger.dart';
import 'package:coffee_challenge/core/utils/share_prefs.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:meta/meta.dart';

part 'coffee_details_state.dart';

class CoffeeDetailsCubit extends Cubit<CoffeeDetailsState> {
  CoffeeDetailsCubit() : super(CoffeeDetailsLoading());

  Future<void> checkFavoriteAddedOrNot(int id) async {
    emit(CoffeeDetailsLoading());
    try {
      final coffeeList = await PreferencesService.getFavorites();
      final isAdded = coffeeList.any((e) => e.id == id);
      logger.i(isAdded);
      emit(CoffeeDetailsChecked(isAdded: isAdded));
    } catch (e) {
      emit(CoffeeDetailsError('Failed to fetch coffee items'));
    }
  }

  Future<void> addToFavorites(CoffeeItem item) async {
    try {
      await PreferencesService.addFavorite(item);
      emit(CoffeeDetailsChecked(isAdded: true));
    } catch (e) {
      emit(CoffeeDetailsError('Failed to remove coffee items'));
    }
  }

  Future<void> removeFavorites(int id) async {
    try {
      await PreferencesService.removeFavorite(id);
      emit(CoffeeDetailsChecked(isAdded: false));
    } catch (e) {
      emit(CoffeeDetailsError('Failed to remove coffee items'));
    }
  }

 void changeSize(int value) {
    emit(CoffeeDetailsSizeChange(value: value));
  }
}
