import 'package:flutter_base_project/core/i10n/default_localization.dart';

class TrLocalization extends AppLocalizationLabel {
  const TrLocalization();

  @override
  final String localizationTitle = 'Türkçe';

  @override
  final String defaultErrorMessage = 'Hata oluştu. Lütfen daha sonra tekrar deneyiniz';

  @override
  final String noInternetErrorMessage = 'Lütfen internet bağlantınızı kontrol ediniz.';

  @override
  final String unauthorizedErrorMessage = 'Bu işlem için yetkiniz bulunmamaktadır.';

  @override
  final String serverErrorMessage = 'Sunucu kaynaklı bi hata oluştu. Lütfen daha sonra tekrar deneyiniz';

  @override
  final String tryAgainBtnText = 'Tekrar Dene';
  
  @override
  final String unknownPageRouteMessageText = 'Route bulunamadı...';

  @override
  final String cannotDeleteSelectedAddressMessage = 'Teslimat adres olarak seçilen adresi silemesiniz.';

  @override
  String get timeoutErrorMessage => 'Bağlantı zaman aşımına uğradı';
}
