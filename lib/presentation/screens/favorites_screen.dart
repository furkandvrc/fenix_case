import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/movie_cubit.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoriler'),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state.status == MovieStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MovieStatus.error) {
            return Center(child: Text(state.message ?? 'Bir hata oluştu'));
          }

          if (state.movies.isEmpty) {
            return const Center(child: Text('Henüz favori film eklenmemiş'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(
                key: ValueKey(movie.id),
                movie: movie,
                onTap: () {
                  context.read<MovieCubit>().toggleFavorite(movie);
                },
              );
            },
          );
        },
      ),
    );
  }
}
