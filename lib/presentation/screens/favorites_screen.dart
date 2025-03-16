import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final MovieController controller = Get.find<MovieController>();

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Obx(() {
        if (controller.favoriteMovies.isEmpty) {
          return const Center(
            child: Text('No favorite movies yet'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: controller.favoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = controller.favoriteMovies[index];
            return MovieCard(
              movie: movie,
              onTap: () => Get.to(() => MovieDetailScreen(movie: movie)),
              onFavoritePressed: () => controller.toggleFavorite(movie),
            );
          },
        );
      }),
    );
  }
}
