import 'package:dio/dio.dart';
import '../../core/network/dio_config.dart';
import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio;
  static const String _apiKey = 'YOUR_API_KEY'; // TMDB API anahtarınızı buraya ekleyin

  MovieRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'tr-TR',
        },
      );
      final List<dynamic> results = response.data['results'];
      return results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
    } catch (e) {
      throw Exception('Popüler filmler alınamadı: ${e.toString()}');
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'api_key': _apiKey,
          'query': query,
          'language': 'tr-TR',
        },
      );
      final List<dynamic> results = response.data['results'];
      return results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
    } catch (e) {
      throw Exception('Film araması yapılamadı: ${e.toString()}');
    }
  }
}
