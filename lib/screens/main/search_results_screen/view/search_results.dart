import 'package:flutter/material.dart';
import 'package:the_moive_db/app/components/image/base_image.dart';
import 'package:the_moive_db/app/components/other/general_error_page.dart';
import 'package:the_moive_db/app/constants/assets/assets.dart';
import 'package:the_moive_db/app/constants/other/padding_and_radius_size.dart';
import 'package:the_moive_db/app/theme/color/app_colors.dart';
import 'package:the_moive_db/app/theme/text_style/text_style.dart';
import 'package:the_moive_db/screens/main/search_results_screen/controller/search_results_controller.dart';
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
                childAspectRatio: 0.38,
              ),
              padding: const EdgeInsets.symmetric(horizontal: paddingM, vertical: paddingXXL),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = controller.searchedListMovies[index];
                return SizedBox(
                  child: Column(
                    children: [
                      _MovieCard(
                        item.posterPath,
                      ),
                      const SizedBox(
                        height: paddingXXXXXXXXL,
                      ),
                      Text(
                        item.title ?? "",
                        style: s18W700Dark,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
              itemCount: controller.searchedListMovies.length,
            )),
    );
  }
}
