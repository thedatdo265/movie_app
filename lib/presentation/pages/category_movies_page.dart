import 'package:flutter/material.dart';
import '../../core/enums/movie_category.dart';
import '../../data/models/movie.dart';
import '../../data/providers/movie_provider.dart';
import '../../core/enums/request_state.dart';
import 'package:provider/provider.dart';
import '../widgets/movie_list.dart';
import '../widgets/search_bar.dart';
import '../widgets/loading_indicator.dart';
import '../pages/movie_detail_page.dart';

class CategoryMoviesPage extends StatefulWidget {
  final MovieCategory category;

  const CategoryMoviesPage({super.key, required this.category});

  @override
  State<CategoryMoviesPage> createState() => _CategoryMoviesPageState();
}

class _CategoryMoviesPageState extends State<CategoryMoviesPage> {
  int _page = 1;
  bool _loadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MovieProvider>(context, listen: false);
    provider.fetchMovies(widget.category);
  }

  void _loadMore() async {
    if (!_hasMore || _loadingMore) return;
    setState(() => _loadingMore = true);

    final provider = Provider.of<MovieProvider>(context, listen: false);
    _page++;
    await provider.fetchMovies(widget.category, page: _page);

    if (provider.getMovies(widget.category).length < 20) _hasMore = false;
    setState(() => _loadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    final movies = provider.getMovies(widget.category);
    final state = provider.getState(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.nameValue),
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
      body: state == RequestState.loading
          ? const LoadingIndicator()
          : Column(
        children: [
          Expanded(
            child: MovieList(
              movies: movies,
              onTapMovie: (movie) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailPage(movie: movie),
                  ),
                );
              },
            ),
          ),
          if (_hasMore)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _loadingMore ? null : _loadMore,
                child: _loadingMore
                    ? const CircularProgressIndicator()
                    : const Text('Load More'),
              ),
            ),
        ],
      ),
    );
  }
}
