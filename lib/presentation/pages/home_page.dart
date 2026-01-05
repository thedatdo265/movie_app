import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/enums/movie_category.dart';
import '../../core/enums/request_state.dart';
import '../../data/providers/movie_provider.dart';
import '../../data/providers/theme_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/search_bar.dart';
import 'category_movies_page.dart';
import '../../data/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    for (var category in MovieCategory.values) {
      movieProvider.fetchMovies(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.currentTheme == AppThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MovieSearchBar(
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  Navigator.pushNamed(context, '/search', arguments: query);
                }
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
              MovieCategory.values.map((category) {
                final state = movieProvider.getState(category);
                final movies = movieProvider.getMovies(category);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category.nameValue,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => CategoryMoviesPage(
                                          category: category,
                                        ),
                                  ),
                                );
                              },
                              child: const Text('See All'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (state == RequestState.loading)
                        const LoadingIndicator()
                      else if (state == RequestState.error)
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Error loading movies'),
                        )
                      else
                        SizedBox(
                          height: 260,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: movies.length > 10 ? 10 : movies.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 12),
                            itemBuilder:
                                (_, index) => SizedBox(
                                  width: 140,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      final movie = movies[index];
                                      Navigator.pushNamed(
                                        context,
                                        '/movie-detail',
                                        arguments: movie,
                                      );
                                    },
                                    child: MovieCard(movie: movies[index]),
                                  ),
                                ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
