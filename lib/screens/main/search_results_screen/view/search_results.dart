import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/components/image/base_image.dart';
import 'package:flutter_base_project/app/components/other/general_error_page.dart';
import 'package:flutter_base_project/app/constants/assets/assets.dart';
import 'package:flutter_base_project/app/constants/other/padding_and_radius_size.dart';
import 'package:flutter_base_project/app/theme/color/app_colors.dart';
import 'package:flutter_base_project/app/theme/text_style/text_style.dart';
import 'package:flutter_base_project/screens/main/search_results_screen/controller/search_results_controller.dart';
import 'package:get/get.dart';

part '../view/components/movie_card.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchResultsController>();
    return Scaffold(
      backgroundColor: AppColors.azureishWhite,
      appBar: AppBar(),
      key: controller.scaffoldKey,
      body: Obx(() => controller.searchedListMovies.isEmpty
          ? GeneralErrorPage(
              onTapTryAgain: controller.tryAgain,
              message: 'No movie was found matching the word you were looking for.',
              btnText: 'Try again',
            )
          : GridView.builder(
              controller: controller.scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: paddingXL,
                crossAxisSpacing: paddingXL,
                childAspectRatio: 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: paddingXL, vertical: paddingXXXXL),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = controller.searchedListMovies[index];
                return _MovieCard(
                  item.posterPath,
                  item.title,
                );
              },
              itemCount: controller.searchedListMovies.length,
            )),
    );
  }
}
