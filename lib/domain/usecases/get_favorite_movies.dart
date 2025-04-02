import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetFavoriteMovies {
  final MovieRepository repository;

  GetFavoriteMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getFavoriteMovies();
  }
}
