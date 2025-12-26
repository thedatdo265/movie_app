enum MovieCategory { trending, popular, topRated, upcoming }

extension MovieCategoryExtension on MovieCategory {
  String get nameValue {
    switch (this) {
      case MovieCategory.trending:
        return 'Trending';
      case MovieCategory.popular:
        return 'Popular';
      case MovieCategory.topRated:
        return 'Top Rated';
      case MovieCategory.upcoming:
        return 'Upcoming';
    }
  }

  String get urlPath {
    switch (this) {
      case MovieCategory.trending:
        return 'trending/movie/week';
      case MovieCategory.popular:
        return 'movie/popular';
      case MovieCategory.topRated:
        return 'movie/top_rated';
      case MovieCategory.upcoming:
        return 'movie/upcoming';
    }
  }
}
