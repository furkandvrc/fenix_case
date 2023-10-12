import 'package:flutter/material.dart';
import 'package:the_moive_db/app/extensions/widgets_scale_extension.dart';
import 'package:the_moive_db/app/theme/color/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50.horizontalScale,
        decoration: BoxDecoration(
          color: AppColors.appBarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
            decoration: InputDecoration(
          hintText: 'Search a movie..',
          suffixIcon: Icon(Icons.close),
          prefixIcon: Icon(Icons.search),
        )));
  }
}
