import 'package:flutter_base_project/app/app.dart';
import 'package:flutter_base_project/app/main/bootstrap/bootstrap.dart';
import '../constants/app/app_constant.dart';
import '../constants/app/http_url.dart';
import '../constants/enum/general_enum.dart';

/// product ortamı
///
/// COMMAND LINE örneği
/// flutter run --flavor product lib/app/main/main_production.dart
/// flutter build apk --release --flavor product lib/app/main/main_production.dart
/// flutter build appbundle --release --flavor product lib/app/main/main_production.dart
void main() {
  environment = AppEnvironment.Production;
  HttpUrl.baseUrl = 'https://api.themoviedb.org/3';

  bootstrap(
    'https://api.themoviedb.org/3/',
    const App(title: 'Movie App'),
  );
}
