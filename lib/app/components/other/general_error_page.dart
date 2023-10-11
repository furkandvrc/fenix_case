import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/constants/assets/assets.dart';
import 'package:flutter_base_project/app/constants/other/padding_and_radius_size.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/text_style/text_style.dart';
import '../button/base_button.dart';

class GeneralErrorPage extends StatelessWidget {
  const GeneralErrorPage({
    Key? key,
    required this.onTapTryAgain,
    this.message,
    this.btnText,
  }) : super(key: key);

  final VoidCallback onTapTryAgain;
  final String? message;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(errorIllustration),
            const SizedBox(height: paddingXXXL),
            Text(
              message ?? 'Uygulama yüklenirken bir hata\noluştu. Üzerinde çalışıyoruz. Lütfen\ntekrar deneyin.',
              style: s14W500Dark,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: paddingXXXL),
            BaseButton(
              onTap: onTapTryAgain,
              txt: btnText ?? 'Tekrar Dene',
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
