import 'package:flutter/material.dart';
import '../../data/models/movie.dart';
import '../../data/services/movie_service.dart';
import '../widgets/movie_list.dart';
import '../widgets/loading_indicator.dart';

class SearchPage extends StatefulWidget {
  final String initialQuery;

  const SearchPage({super.key, this.initialQuery = ''}); // default ''

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  List<Movie> _results = [];
  bool _loading = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);

    if (widget.initialQuery.isNotEmpty) {
      _search(widget.initialQuery);
    }
  }

  void _search(String query) async {
    if (query.isEmpty) return;
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final movies = await movieService.searchMovies(query);
      setState(() {
        _results = movies;
      });
    } catch (_) {
      setState(() {
        _error = 'Error searching movies';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Movies')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _search,
            ),
            const SizedBox(height: 8),
            if (_loading)
              const LoadingIndicator()
            else if (_error.isNotEmpty)
              Text(_error)
            else
              Expanded(child: MovieList(movies: _results)),
          ],
        ),
      ),
    );
  }
}
