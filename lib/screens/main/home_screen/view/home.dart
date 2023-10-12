import 'package:flutter/material.dart';
import 'package:the_moive_db/app/components/input_fields/search_field.dart';
import 'package:the_moive_db/app/constants/assets/assets.dart';
import 'package:the_moive_db/app/extensions/widgets_scale_extension.dart';
import 'package:the_moive_db/app/theme/text_style/text_style.dart';
import 'package:the_moive_db/screens/main/home_screen/view/components/search_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 120.verticalScale, horizontal: 20.horizontalScale),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(logo),
                SizedBox(height: 100.verticalScale),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome\n',
                        style: s18W700Dark,
                      ),
                      TextSpan(
                        text: 'Millions of movies, TV shows and people to discover. Explore now.',
                        style: s18W400Dark,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.verticalScale),
                SearchField(
                  onSubmitted: (query) {
                    if (query!.isNotEmpty) {
                      controller.onSubmitted();
                    }
                  },
                  controller: controller.cSearch,
                  onChanged: controller.onChangeSearch,
                  queryDelete: controller.clearSearch,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
