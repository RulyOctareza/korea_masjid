import 'package:flutter/material.dart';
import 'package:masjidkorea/widgets/tips.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Tips> _favorites = [];

  List<Tips> get favorites => _favorites;

  void addFavorite(Tips tip) {
    _favorites.add(tip);
    notifyListeners();
  }

  void removeFavorite(Tips tip) {
    _favorites.remove(tip);
    notifyListeners();
  }
}
