import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fenix_case/domain/entities/movie.dart';
import 'package:fenix_case/domain/repositories/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;
  int _currentPage = 1;
  bool _isLoading = false;

  MovieCubit(this._movieRepository) : super(const MovieState());

  Future<void> getMovies() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final result = await _movieRepository.getMovies(_currentPage);
      result.fold(
        (failure) => emit(state.copyWith(
          status: MovieStatus.error,
          message: failure.message,
        )),
        (movies) {
          _currentPage++;
          emit(state.copyWith(
            status: MovieStatus.success,
            movies: [...state.movies, ...movies],
            hasReachedEnd: movies.isEmpty,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        message: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _currentPage = 1;
      emit(state.copyWith(
        status: MovieStatus.initial,
        movies: [],
        hasReachedEnd: false,
      ));
      await getMovies();
      return;
    }

    if (_isLoading) return;
    _isLoading = true;

    try {
      final result = await _movieRepository.searchMovies(query);
      result.fold(
        (failure) => emit(state.copyWith(
          status: MovieStatus.error,
          message: failure.message,
        )),
        (movies) {
          emit(state.copyWith(
            status: MovieStatus.success,
            movies: movies,
            hasReachedEnd: true,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        message: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> toggleFavorite(Movie movie) async {
    try {
      final result = await _movieRepository.toggleFavorite(movie);
      result.fold(
        (failure) => emit(state.copyWith(
          status: MovieStatus.error,
          message: failure.message,
        )),
        (updatedMovie) {
          final updatedMovies = state.movies.map((m) {
            return m.id == updatedMovie.id ? updatedMovie : m;
          }).toList();

          emit(state.copyWith(
            status: MovieStatus.success,
            movies: updatedMovies,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        message: e.toString(),
      ));
    }
  }

  Future<void> getFavorites() async {
    try {
      final result = await _movieRepository.getFavorites();
      result.fold(
        (failure) => emit(state.copyWith(
          status: MovieStatus.error,
          message: failure.message,
        )),
        (movies) {
          emit(state.copyWith(
            status: MovieStatus.success,
            movies: movies,
            hasReachedEnd: true,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        message: e.toString(),
      ));
    }
  }
}
