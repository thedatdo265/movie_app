import 'package:flutter/material.dart';
import '../../core/enums/movie_category.dart';
import '../../core/enums/request_state.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final Map<MovieCategory, RequestState> _state = {};
  final Map<MovieCategory, List<Movie>> _movies = {};

  RequestState getState(MovieCategory category) =>
      _state[category] ?? RequestState.loading;

  List<Movie> getMovies(MovieCategory category) => _movies[category] ?? [];

  Future<void> fetchMovies(MovieCategory category, {int page = 1}) async {
    if (page == 1) {
      _state[category] = RequestState.loading;
      notifyListeners();
    }

    try {
      final movies = await movieService.fetchMovies(category, page: page);

      if (page == 1) {
        _movies[category] = movies;
      } else {
        _movies[category]?.addAll(movies);
      }
      _state[category] = RequestState.success;
    } catch (e) {
      print('Error fetching ${category.name}: $e');
      _state[category] = RequestState.error;
    }
    notifyListeners();
  }
}
