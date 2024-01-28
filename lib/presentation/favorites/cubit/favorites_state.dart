part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  FavoritesLoaded(this.coffeeItems);
  final List<CoffeeItem> coffeeItems;
}

final class FavoritesError extends FavoritesState {
  FavoritesError(this.error);
  final String error;
}

final class FavoritesRemoved extends FavoritesState {
  FavoritesRemoved(this.coffeeItems, this.index);
  final CoffeeItem coffeeItems;
  final int index;
}
