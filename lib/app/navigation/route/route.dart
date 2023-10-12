import 'package:flutter/material.dart' show PageRoute, RouteSettings;
import 'package:the_moive_db/app/navigation/route/page_route_builder.dart';
import 'package:the_moive_db/screens/screens.dart';

typedef PageRouteFun = PageRoute Function(RouteSettings);

enum MainScreensEnum {
  init('/'),
  homeScreen('home/homeScreen'),
  searchResultsScreen("searchResults/searchResultsScreen");

  const MainScreensEnum(this.path);

  final String path;
}

Map<String, PageRouteFun> mainRoutesMap = {
  MainScreensEnum.init.path: (_) => goToPage(const SplashScreen(), _),
  MainScreensEnum.homeScreen.path: (_) => goToPage(const HomeScreen(), _),
  MainScreensEnum.searchResultsScreen.path: (_) => goToPage(const SearchResultsScreen(), _),
};
