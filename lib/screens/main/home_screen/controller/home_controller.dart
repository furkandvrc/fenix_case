import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/constants/enum/loading_status_enum.dart';
import 'package:flutter_base_project/app/model/response/search_response_model.dart';
import 'package:flutter_base_project/app/navigation/route/route.dart';
import 'package:get/get.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../../../../app/bl/general.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext get context => scaffoldKey.currentContext!;

  final Rx<List<Result>> _searchedListMovies = Rx([]);

  final TextEditingController cSearch = TextEditingController();

  final Rx<LoadingStatus> _loadingStatus = Rx(LoadingStatus.Init);

  bool isSearchActive = false;

  late int page;

  LoadingStatus get loadingStatus => _loadingStatus.value;
  set loadingStatus(LoadingStatus value) => _loadingStatus.value = value;

  List<Result> get searchedListMovies => _searchedListMovies.value;
  set searchedListMovies(List<Result> value) => _searchedListMovies.value = value;

  @override
  void onReady() async {
    super.onReady();
    try {
      OverlayLoadingProgress.start();
      loadingStatus = LoadingStatus.Loading;
      searchedListMovies.isEmpty ? await Future.delayed(const Duration(seconds: 1)) : searchedListMovies;
      loadingStatus = LoadingStatus.Loaded;
    } catch (e) {
      loadingStatus = LoadingStatus.Error;
    } finally {
      OverlayLoadingProgress.stop();
    }
  }

  void onChangeSearch(String? _) async {
    if (cSearch.text.trim().length >= 2) {
      isSearchActive = true;

      final searchSlug = cSearch.text.toLowerCase();
      final searchResponse = await General().search(searchSlug, 1);
      final movies = searchResponse.data?.results ?? [];

      // İlk sayfa sonuçlarını ekliyoruz
      searchedListMovies = movies;

      // Toplam sayfa sayısını alıyoruz
      final totalPage = searchResponse.data?.totalPages ?? 1;

      // Diğer sayfaları döngü ile ekliyoruz
      for (int i = 2; i <= totalPage; i++) {
        final nextPageResponse = await General().search(searchSlug, i);
        final nextPageMovies = nextPageResponse.data?.results ?? [];
        searchedListMovies.addAll(nextPageMovies);
      }
    } else {
      isSearchActive = false;
      searchedListMovies = [];
    }
  }

  void onSubmitted() => Navigator.pushNamed(
        scaffoldKey.currentContext!,
        MainScreensEnum.searchResultsScreen.path,
      );

  void deactivateSearch() {
    cSearch.text = '';
    isSearchActive = false;
  }

  void clearSearch() {
    cSearch.text = '';
  }
}
