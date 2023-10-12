part of '../../../search_results_screen/view/search_results.dart';

class _MovieCard extends StatelessWidget {
  final String? posterPath;

  const _MovieCard(this.posterPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 330,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: posterPath == null
              ? Image.asset(placeHolder).image
              : NetworkImage(
                  "https://image.tmdb.org/t/p/w220_and_h330_face/$posterPath",
                ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
