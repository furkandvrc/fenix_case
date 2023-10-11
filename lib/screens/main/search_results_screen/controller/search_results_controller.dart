import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/bl/general.dart';
import 'package:flutter_base_project/app/constants/enum/loading_status_enum.dart';
import 'package:flutter_base_project/app/model/response/search_response_model.dart';
import 'package:flutter_base_project/app/navigation/route/route.dart';
import 'package:flutter_base_project/screens/main/home_screen/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:overlay_kit/overlay_kit.dart';

class SearchResultsController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController scrollController = ScrollController();

  BuildContext get context => scaffoldKey.currentContext!;

  final Rx<List<Result>> _searchedListMovies = Rx([]);

  final TextEditingController cSearch = TextEditingController();

  final Rx<LoadingStatus> _loadingStatus = Rx(LoadingStatus.Init);

  bool isSearchActive = false;

  int page = 1;

  HomeController? controllerHome;

  LoadingStatus get loadingStatus => _loadingStatus.value;
  set loadingStatus(LoadingStatus value) => _loadingStatus.value = value;

  List<Result> get searchedListMovies => _searchedListMovies.value;
  set searchedListMovies(List<Result> value) {
    _searchedListMovies.firstRebuild = true;
    _searchedListMovies.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      OverlayLoadingProgress.start();
      loadingStatus = LoadingStatus.Loading;
      await Future.delayed(const Duration(seconds: 1));
      if (Get.isRegistered<HomeController>()) {
        controllerHome = Get.find<HomeController>();
        cSearch.text = controllerHome!.cSearch.text;
        page = page;
        searchedListMovies = controllerHome!.searchedListMovies;
      }
      await Future.delayed(const Duration(seconds: 1));
      loadingStatus = LoadingStatus.Loaded;
    } catch (e) {
      loadingStatus = LoadingStatus.Error;
    } finally {
      OverlayLoadingProgress.stop();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      page++;
      print(page);
    }
  }

  void tryAgain() => Navigator.pushNamedAndRemoveUntil(context, MainScreensEnum.homeScreen.path, (route) => false);

  void deactivateSearch() {
    cSearch.text = '';
    isSearchActive = false;
  }

  void clearSearch() {
    cSearch.text = '';
  }
}
