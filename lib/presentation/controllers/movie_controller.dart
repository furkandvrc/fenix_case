import 'package:get/get.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieController extends GetxController {
  final MovieRepository _repository;

  MovieController(this._repository);

  final RxList<Movie> movies = <Movie>[].obs;
  final RxList<Movie> favoriteMovies = <Movie>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMorePages = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _loadFavorites();
      await fetchTopRatedMovies();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final favorites = await _repository.getFavoriteMovies();
      favoriteMovies.value = favorites;

      // Mevcut filmlerin favori durumlarını güncelle
      _updateMoviesFavoriteStatus();
    } catch (e) {
      print('Failed to load favorites: $e');
    }
  }

  void _updateMoviesFavoriteStatus() {
    final List<Movie> updatedMovies = movies.map((movie) {
      final isFavorite = favoriteMovies.any((f) => f.id == movie.id);
      return movie.copyWith(isFavorite: isFavorite);
    }).toList();

    movies.value = updatedMovies;
  }

  Future<void> fetchTopRatedMovies({bool loadMore = false}) async {
    if (!loadMore) {
      currentPage.value = 1;
      hasMorePages.value = true;
    }

    if (!hasMorePages.value) return;

    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        movies.clear();
      }
      error.value = '';

      final newMovies = await _repository.getTopRatedMovies(page: currentPage.value);

      if (newMovies.isEmpty) {
        hasMorePages.value = false;
      } else {
        final updatedMovies = newMovies.map((movie) {
          final isFavorite = favoriteMovies.any((f) => f.id == movie.id);
          return movie.copyWith(isFavorite: isFavorite);
        }).toList();

        if (loadMore) {
          movies.addAll(updatedMovies);
        } else {
          movies.value = updatedMovies;
        }
        currentPage.value++;
      }
    } catch (e) {
      error.value = 'Failed to fetch movies';
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.length < 2) {
      await fetchTopRatedMovies();
      return;
    }

    try {
      currentPage.value = 1;
      hasMorePages.value = true;
      isLoading.value = true;
      error.value = '';
      searchQuery.value = query;
      movies.clear();

      final searchResults = await _repository.searchMovies(query, page: currentPage.value);

      if (searchResults.isEmpty) {
        hasMorePages.value = false;
      } else {
        final updatedResults = searchResults.map((movie) {
          final isFavorite = favoriteMovies.any((f) => f.id == movie.id);
          return movie.copyWith(isFavorite: isFavorite);
        }).toList();

        movies.value = updatedResults;
        currentPage.value++;
      }
    } catch (e) {
      error.value = 'Failed to search movies';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreSearchResults() async {
    if (!hasMorePages.value || searchQuery.isEmpty) return;

    try {
      isLoadingMore.value = true;
      error.value = '';

      final searchResults = await _repository.searchMovies(
        searchQuery.value,
        page: currentPage.value,
      );

      if (searchResults.isEmpty) {
        hasMorePages.value = false;
      } else {
        final updatedResults = searchResults.map((movie) {
          final isFavorite = favoriteMovies.any((f) => f.id == movie.id);
          return movie.copyWith(isFavorite: isFavorite);
        }).toList();

        movies.addAll(updatedResults);
        currentPage.value++;
      }
    } catch (e) {
      error.value = 'Failed to load more results';
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> toggleFavorite(Movie movie) async {
    try {
      await _repository.toggleFavorite(movie);

      final newIsFavorite = !movie.isFavorite;
      final updatedMovie = movie.copyWith(isFavorite: newIsFavorite);

      // Ana listedeki filmi güncelle
      final index = movies.indexWhere((m) => m.id == movie.id);
      if (index != -1) {
        movies[index] = updatedMovie;
      }

      // Favori listesini güncelle
      if (newIsFavorite) {
        if (!favoriteMovies.any((m) => m.id == movie.id)) {
          favoriteMovies.add(updatedMovie);
        }
      } else {
        favoriteMovies.removeWhere((m) => m.id == movie.id);
      }
    } catch (e) {
      error.value = 'Failed to update favorite status';
    }
  }
}
