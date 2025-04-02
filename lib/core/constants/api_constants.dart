class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YjQ0NzgwNThhNWUzMTBjZTYzNjBjMzhlYzUxZWNlNiIsIm5iZiI6MTc0MzU4MzY1Ny45NDMsInN1YiI6IjY3ZWNmOWE5ZTE1N2FlZjNmMjAxM2IzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3KdclppBbMPiZ-91vYtikbEbbqIMfN5mQm51PT_59dk';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String popularMovies = '$baseUrl/movie/popular';
  static const String searchMovies = '$baseUrl/search/movie';

  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl$path';
  }

  static const String topRatedMovies = '/movie/top_rated';
  static const String movieDetails = '/movie';
}
