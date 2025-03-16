import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio = DioClient.instance;
  final SharedPreferences _prefs;
  final String _favoritesKey = 'favorite_movies';

  MovieRepositoryImpl(this._prefs);

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstants.topRatedMovies,
        queryParameters: {'page': page},
      );
      final List<dynamic> results = response.data['results'];
      final movies = results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
      return _attachFavoriteStatus(movies);
    } catch (e) {
      throw Exception('Failed to fetch top rated movies');
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstants.searchMovies,
        queryParameters: {
          'query': query,
          'page': page,
        },
      );
      final List<dynamic> results = response.data['results'];
      final movies = results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
      return _attachFavoriteStatus(movies);
    } catch (e) {
      throw Exception('Failed to search movies');
    }
  }

  @override
  Future<Movie> getMovieDetails(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.movieDetails}/$id');
      final movie = MovieModel.fromJson(response.data).toEntity();
      return _attachFavoriteStatus([movie]).first;
    } catch (e) {
      throw Exception('Failed to fetch movie details');
    }
  }

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    final favoriteIds = _getFavoriteIds();
    final List<Movie> favoriteMovies = [];

    for (final id in favoriteIds) {
      try {
        final movie = await getMovieDetails(id);
        favoriteMovies.add(movie.copyWith(isFavorite: true));
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
    } else {
      favoriteIds.add(movie.id);
    }

    await _prefs.setStringList(_favoritesKey, favoriteIds.map((id) => id.toString()).toList());
  }

  Set<int> _getFavoriteIds() {
    final List<String> favoriteIdsStr = _prefs.getStringList(_favoritesKey) ?? [];
    return favoriteIdsStr.map((idStr) => int.parse(idStr)).toSet();
  }

  List<Movie> _attachFavoriteStatus(List<Movie> movies) {
    final favoriteIds = _getFavoriteIds();
    return movies.map((movie) => movie.copyWith(isFavorite: favoriteIds.contains(movie.id))).toList();
  }
}
