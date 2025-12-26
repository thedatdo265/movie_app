import 'package:flutter/material.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/movie_detail_page.dart';
import '../presentation/pages/search_page.dart';
import '../presentation/pages/favorites_page.dart';
import '../data/models/movie.dart';

class Routes {
  static const home = '/';
  static const movieDetail = '/movie-detail';
  static const search = '/search';
  static const favorites = '/favorites';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case movieDetail:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie));
      case search:
        final query = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => SearchPage(initialQuery: query ?? ''),
        );
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      default:
        return null;
    }
  }
}
