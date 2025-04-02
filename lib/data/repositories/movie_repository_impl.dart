import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;
  final SharedPreferences _prefs;
  static const String _favoritesKey = 'favorites';

  MovieRepositoryImpl(this._dio, this._prefs);

  @override
  Future<Either<Failure, List<Movie>>> getMovies(int page) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results.map((json) => MovieModel.fromJson(json)).map((model) => model.toEntity()).toList();

        final favorites = await _getFavoriteIds();
        return Right(movies.map((movie) {
          return movie.copyWith(isFavorite: favorites.contains(movie.id));
        }).toList());
      } else {
        return const Left(ServerFailure('Failed to fetch movies'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final movies = results.map((json) => MovieModel.fromJson(json)).map((model) => model.toEntity()).toList();

        final favorites = await _getFavoriteIds();
        return Right(movies.map((movie) {
          return movie.copyWith(isFavorite: favorites.contains(movie.id));
        }).toList());
      } else {
        return const Left(ServerFailure('Failed to search movies'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavorites() async {
    try {
      final favorites = await _getFavoriteMovies();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Movie>> toggleFavorite(Movie movie) async {
    try {
      final favorites = await _getFavoriteMovies();
      final index = favorites.indexWhere((m) => m.id == movie.id);

      if (index >= 0) {
        favorites.removeAt(index);
        final updatedMovie = movie.copyWith(isFavorite: false);
        await _saveFavoriteMovies(favorites);
        return Right(updatedMovie);
      } else {
        final updatedMovie = movie.copyWith(isFavorite: true);
        favorites.add(updatedMovie);
        await _saveFavoriteMovies(favorites);
        return Right(updatedMovie);
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<List<int>> _getFavoriteIds() async {
    final favorites = await _getFavoriteMovies();
    return favorites.map((movie) => movie.id).toList();
  }

  Future<List<Movie>> _getFavoriteMovies() async {
    final String? jsonString = _prefs.getString(_favoritesKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => MovieModel.fromJson(json).toEntity()).toList();
  }

  Future<void> _saveFavoriteMovies(List<Movie> movies) async {
    final jsonList = movies.map((movie) => MovieModel.fromEntity(movie).toJson()).toList();
    await _prefs.setString(_favoritesKey, json.encode(jsonList));
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    return getMovies(1);
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavoriteMovies() async {
    return getFavorites();
  }
}
