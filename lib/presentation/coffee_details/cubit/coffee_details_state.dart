part of 'coffee_details_cubit.dart';

@immutable
sealed class CoffeeDetailsState {}

class CoffeeDetailsLoading extends CoffeeDetailsState {}

class CoffeeDetailsChecked extends CoffeeDetailsState {
  CoffeeDetailsChecked({required this.isAdded});

  final bool isAdded;
}

final class CoffeeDetailsError extends CoffeeDetailsState {
  CoffeeDetailsError(this.error);

  final String error;
}

class CoffeeDetailsSizeChange extends CoffeeDetailsState {
  CoffeeDetailsSizeChange({required this.value});

  final int value;
}
