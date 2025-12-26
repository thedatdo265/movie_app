import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../../core/constants.dart';
import '../../core/enums/movie_category.dart';

class MovieService {
  Future<List<Movie>> fetchMovies(
    MovieCategory category, {
    int page = 1,
  }) async {
    final url = Uri.parse(
      '$baseUrl/${category.urlPath}?api_key=$apiKey&page=$page',
    );
    print('Fetching URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final results = body['results'] as List<dynamic>? ?? [];
      return results
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&page=$page',
    );
    print('Searching URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final results = body['results'] as List<dynamic>? ?? [];
      return results
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to search movies: ${response.statusCode}');
    }
  }
}

final movieService = MovieService();
