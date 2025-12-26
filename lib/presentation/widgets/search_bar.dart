import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  final void Function(String) onSubmitted;

  const MovieSearchBar({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search movies...',
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
