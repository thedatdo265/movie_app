import 'package:flutter/material.dart';
import '../models/movie.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  void addFavorite(Movie movie) {
    if (!_favorites.any((m) => m.id == movie.id)) {
      _favorites.add(movie);
      notifyListeners();
    }
  }

  void removeFavorite(Movie movie) {
    _favorites.removeWhere((m) => m.id == movie.id);
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.any((m) => m.id == movie.id);
  }
}
