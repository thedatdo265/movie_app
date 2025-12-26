import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/favorites_provider.dart';
import '../widgets/movie_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body:
          favorites.isEmpty
              ? const Center(child: Text('No favorite movies'))
              : MovieList(movies: favorites),
    );
  }
}
