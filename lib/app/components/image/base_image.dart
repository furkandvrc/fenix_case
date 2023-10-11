import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseImage extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;
  final Widget? errorWidget;
  final BoxFit? fit;
  const BaseImage({super.key, this.imageUrl, this.errorWidget, this.fit, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? Image.asset(
            imagePath!,
            fit: fit,
          )
        : CachedNetworkImage(
            fit: fit,
            imageUrl: imageUrl!,
            errorWidget: (context, url, error) =>
                errorWidget ??
                const Center(
                  child: Icon(Icons.image),
                ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          );
  }
}
