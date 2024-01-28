import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/utils/share_prefs.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesLoading());

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Future<void> get getFavoritesList async {
    emit(FavoritesLoading());
    try {
      final coffeeList = await PreferencesService.getFavorites();
      emit(FavoritesLoaded(coffeeList));
    } catch (e) {
      emit(FavoritesError('Failed to fetch coffee items'));
    }
  }

  Future<void> removeFavorites(CoffeeItem item,int index) async {
    // emit(FavoritesLoading());
    try {
      final revisedList = await PreferencesService.removeFavorite(item.id);
      emit(FavoritesRemoved(item, index));
      emit(FavoritesLoaded(revisedList));
    } catch (e) {
      emit(FavoritesError('Failed to delete coffee items'));
    }
  }
}
