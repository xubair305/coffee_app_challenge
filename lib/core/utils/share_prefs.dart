import 'dart:convert';

import 'package:coffee_challenge/core/utils/app_logger.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _keyFavorites = 'favorites';

  static Future<List<CoffeeItem>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_keyFavorites) ?? '[]';

    final decodedList = json.decode(jsonString) as List<dynamic>?;

    final favoritesList = List<CoffeeItem>.from(
      (decodedList ?? []).map<CoffeeItem>(
        (x) => CoffeeItem.fromJson(x as Map<String, dynamic>),
      ),
    );
    logger.e(decodedList);
    return favoritesList;
  }

  static Future<void> addFavorite(CoffeeItem newItem) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesList = await getFavorites();

    if (!favoritesList.any((item) => item.id == newItem.id)) {
      favoritesList.add(newItem);
      final jsonString = json.encode(favoritesList);
      await prefs.setString(_keyFavorites, jsonString);
    }
  }

  static Future<List<CoffeeItem>> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesList = await getFavorites();
    favoritesList.removeWhere((e) => e.id == id);
    final jsonString = json.encode(favoritesList);
    logger.d(jsonString);
    await prefs.setString(_keyFavorites, jsonString);
    return favoritesList;
  }
}
