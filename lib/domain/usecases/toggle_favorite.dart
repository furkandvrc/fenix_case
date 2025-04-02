import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class ToggleFavorite {
  final MovieRepository repository;

  ToggleFavorite(this.repository);

  Future<Either<Failure, void>> call(Movie movie) async {
    return await repository.toggleFavorite(movie);
  }
}
