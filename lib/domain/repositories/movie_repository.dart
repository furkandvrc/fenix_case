import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTopRatedMovies({int page = 1});
  Future<List<Movie>> searchMovies(String query, {int page = 1});
  Future<Movie> getMovieDetails(int id);
  Future<List<Movie>> getFavoriteMovies();
  Future<void> toggleFavorite(Movie movie);
}
