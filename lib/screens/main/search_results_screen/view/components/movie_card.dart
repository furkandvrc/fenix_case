part of '../../../search_results_screen/view/search_results.dart';

class _MovieCard extends StatelessWidget {
  final String? posterPath;
  final String? title;
  const _MovieCard(this.posterPath, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseImage(
            imageUrl: posterPath == null ? null : "https://image.tmdb.org/t/p/w220_and_h330_face/$posterPath",
            errorWidget: const Center(
              child: Icon(Icons.image),
            ),
            fit: BoxFit.cover,
            imagePath: placeHolder,
            key: UniqueKey()),
        const SizedBox(
          height: paddingL,
        ),
        Text(
          title ?? "",
          style: s12W500Dark,
        )
      ],
    );
  }
}
