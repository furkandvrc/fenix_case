import 'package:flutter/material.dart';
import 'package:the_moive_db/screens/main/search_results_screen/controller/search_results_controller.dart';
import 'package:the_moive_db/screens/main/search_results_screen/view/search_results.dart';
import 'package:get/get.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchResultsController(),
      builder: (GetxController controller) {
        return const SearchResults();
      },
    );
  }
}
