import '../../constants/enum/general_enum.dart';


class EnvironmentConfigModel {
  EnvironmentConfigModel({
    this.appName,
    required this.environment,
    required this.apiBaseUrl,
  });

  final String? appName;
  final AppEnvironment environment;
  final String apiBaseUrl;
}
