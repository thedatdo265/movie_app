import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(genre));
  }
}
