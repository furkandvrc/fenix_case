import 'package:flutter_base_project/core/i10n/default_localization.dart';

class EnLocalization extends AppLocalizationLabel {
  const EnLocalization();
  
  @override
  final String localizationTitle = 'English';

  @override
  final String defaultErrorMessage = 'An error occurred. Please try again later';

  @override
  final String noInternetErrorMessage = 'Please check your internet connection.';

  @override
  final String unauthorizedErrorMessage = 'You do not have the authority for this operation.';

  @override
  final String serverErrorMessage = 'A server-related error occurred. Please try again later';

  @override
  final String tryAgainBtnText = 'Try Again';

  @override
  final String unknownPageRouteMessageText = 'Route not found...';

  @override
  final String cannotDeleteSelectedAddressMessage = 'You cannot delete the selected delivery address.';

  @override
  String get timeoutErrorMessage => 'The connection has timed out';
}
