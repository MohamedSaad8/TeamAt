import 'package:flutter/material.dart';
import 'package:team_at/view/welcome_view.dart';
import 'package:team_at/viewModel/app_langauge_viewModel.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AppLanguageViewModel>(
        init: AppLanguageViewModel(),
        builder: (controller) => Column(
          children: [
            SizedBox(height: 124.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "selectLanguage".tr,
                textAlignment:controller.currentAppLanguage == "ar"
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                fontColor: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioListTile(
              value: "ar",
              groupValue: controller.currentAppLanguage,
              onChanged: (value)  {
                controller.changeSelectedLanguage(value);
                Get.updateLocale(Locale(value));
              },
              title: CustomText(
                text: "العربية",
                fontSize: 18.sp,
                textAlignment: controller.currentAppLanguage == "ar"
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
              ),
            ),
            RadioListTile(
              value: "en",
              groupValue: controller.currentAppLanguage,
              onChanged: (value)   {
                controller.changeSelectedLanguage(value);
                Get.updateLocale(Locale(value));
              },
              title: CustomText(
                text: "English",
                fontSize: 15.sp,
                textAlignment: controller.currentAppLanguage == "ar"
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 400.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonRadius: 12,
                buttonWidth: size.width,
                buttonFontSize: 16.sp,
                buttonHeight: 58.h,
                onClick: () {
                  Get.off(() => WelcomeView());
                },
                text: "next".tr,
              ),
            )
          ],
        ),
      ),
    );
  }
}
