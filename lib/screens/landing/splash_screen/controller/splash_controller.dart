import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_moive_db/app/navigation/route/route.dart';
import 'package:get/get.dart';
import 'package:the_moive_db/app/extensions/context_extension.dart';
import 'package:the_moive_db/core/i10n/i10n.dart';
import '../../../../app/components/message/error_message_dialog.dart';

class SplashController extends GetxController {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    super.onReady();
    ready();
  }

  BuildContext get context => scaffoldKey.currentContext!;

  void init() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> ready() async {
    final Future splashDelay = Future.delayed(const Duration(seconds: 2));
    await Get.deleteAll();

    if (!await context.checkInternet()) {
      tryAgainMessage(AppLocalization.getLabels.noInternetErrorMessage);
      return;
    }

    try {
      splashDelay.whenComplete(
        () => Navigator.pushNamedAndRemoveUntil(context, MainScreensEnum.homeScreen.path, (route) => false),
      );
    } catch (e) {
      debugPrint(e.toString());
      tryAgainMessage(AppLocalization.getLabels.defaultErrorMessage);
    }
  }

  /// Tekrar yükle popup
  tryAgainMessage(String message) {
    ErrorMessageDialog(
      text: message,
      buttonText: AppLocalization.getLabels.tryAgainBtnText,
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
        ready();
      },
    ).show(barrierDismissible: false);
  }
}
