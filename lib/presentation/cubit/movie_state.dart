part of 'movie_cubit.dart';

enum MovieStatus { initial, loading, success, error }

class MovieState extends Equatable {
  final MovieStatus status;
  final List<Movie> movies;
  final String? message;
  final bool hasReachedEnd;

  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const [],
    this.message,
    this.hasReachedEnd = false,
  });

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
    String? message,
    bool? hasReachedEnd,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      message: message ?? this.message,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [status, movies, message, hasReachedEnd];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object?> get props => [message];
}
