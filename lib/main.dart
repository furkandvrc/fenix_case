import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'presentation/controllers/movie_controller.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/favorites_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final MovieRepository repository = MovieRepositoryImpl(prefs);

  Get.put<MovieRepository>(repository);
  Get.put(MovieController(repository));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/favorites', page: () => FavoritesScreen()),
      ],
    );
  }
}
