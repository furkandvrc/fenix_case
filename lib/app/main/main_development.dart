import '../app.dart';
import '../constants/app/app_constant.dart';
import '../constants/app/http_url.dart';
import '../constants/enum/general_enum.dart';
import 'bootstrap/bootstrap.dart';

/// Development ortamı
///
/// COMMAND LINE örneği
/// flutter run --flavor development lib/app/main/main_development.dart
/// flutter build appbundle --release --flavor development lib/app/main/main_development.dart
void main() {
  environment = AppEnvironment.Development;
  HttpUrl.baseUrl = 'https://api.themoviedb.org/3/';

  bootstrap(
    'https://api.themoviedb.org/3/',
    const App(title: 'Movie App - Development'),
  );
}
