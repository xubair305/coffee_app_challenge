import 'package:bloc/bloc.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<List<CoffeeItem>> {
  SearchCubit(super.coffeeItems) : _coffeeItems = coffeeItems;

  final List<CoffeeItem> _coffeeItems;

  void onSearchChange(String query) {
    final searchedItem = _coffeeItems.where((element) {
      final title = element.title.toLowerCase();
      final subTitle = element.subTitle.toLowerCase();
      final searchVal = query.toLowerCase();
      return title.contains(searchVal) || subTitle.contains(searchVal);
    }).toList();

    emit(searchedItem);
  }
}
