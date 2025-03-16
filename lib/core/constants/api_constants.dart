class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'a6c08cda11c5499ee1534afbd6143955';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w220_and_h330_face';

  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl$path';
  }

  static const String topRatedMovies = '/movie/top_rated';
  static const String searchMovies = '/search/movie';
  static const String movieDetails = '/movie';
}
