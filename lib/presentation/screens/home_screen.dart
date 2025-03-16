import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieController controller = Get.find<MovieController>();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _setupScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (!controller.isLoadingMore.value && controller.hasMorePages.value) {
          if (controller.searchQuery.isEmpty) {
            controller.fetchTopRatedMovies(loadMore: true);
          } else {
            controller.loadMoreSearchResults();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed('/favorites'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) => controller.searchMovies(query),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.error.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.error.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => controller.fetchTopRatedMovies(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.movies.isEmpty) {
                return const Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo is ScrollEndNotification) {
                    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
                      if (!controller.isLoadingMore.value && controller.hasMorePages.value) {
                        if (controller.searchQuery.isEmpty) {
                          controller.fetchTopRatedMovies(loadMore: true);
                        } else {
                          controller.loadMoreSearchResults();
                        }
                      }
                    }
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    GridView.builder(
                      key: const PageStorageKey('movies_grid'),
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 16,
                        bottom: 80,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: controller.movies.length,
                      itemBuilder: (context, index) {
                        final movie = controller.movies[index];
                        return MovieCard(
                          key: ValueKey(movie.id),
                          movie: movie,
                          onTap: () => Get.to(() => MovieDetailScreen(movie: movie)),
                          onFavoritePressed: () => controller.toggleFavorite(movie),
                        );
                      },
                    ),
                    if (controller.isLoadingMore.value)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Loading more movies...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
