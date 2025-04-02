import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<Movie>> getFavoriteMovies();
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isFavorite(int movieId);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences _prefs;
  final String _favoritesKey = 'favorite_movies';

  MovieLocalDataSourceImpl(this._prefs);

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    final favoriteIds = _getFavoriteIds();
    final List<Movie> favoriteMovies = [];

    for (final id in favoriteIds) {
      try {
        final movieJson = _prefs.getString('movie_$id');
        if (movieJson != null) {
          final movie = MovieModel.fromJsonString(movieJson).toEntity();
          favoriteMovies.add(movie.copyWith(isFavorite: true));
        }
      } catch (e) {
        print('Failed to fetch favorite movie with id: $id');
      }
    }

    return favoriteMovies;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final favoriteIds = _getFavoriteIds();

    if (favoriteIds.contains(movie.id)) {
      favoriteIds.remove(movie.id);
      await _prefs.remove('movie_${movie.id}');
    } else {
      favoriteIds.add(movie.id);
      await _prefs.setString('movie_${movie.id}', MovieModel.fromEntity(movie).toJsonString());
    }

    await _prefs.setStringList(_favoritesKey, favoriteIds.map((id) => id.toString()).toList());
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final favoriteIds = _getFavoriteIds();
    return favoriteIds.contains(movieId);
  }

  Set<int> _getFavoriteIds() {
    final List<String> favoriteIds = _prefs.getStringList(_favoritesKey) ?? [];
    return favoriteIds.map((id) => int.parse(id)).toSet();
  }
}
