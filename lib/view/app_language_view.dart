import 'package:flutter/material.dart';
import 'package:team_at/view/welcome_view.dart';
import 'package:team_at/viewModel/app_langauge_viewModel.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:get/get.dart';

class AppLanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        child: GetBuilder<AppLanguageViewModel>(
          init: AppLanguageViewModel(),
          builder: (controller) => Column(
            children: [
              SizedBox(height: size.height *0.1,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: "selectLanguage".tr,
                  textAlignment:controller.currentAppLanguage == "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  fontColor: Colors.black,
                  fontSize: 20,
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
                  textAlignment: controller.currentAppLanguage == "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                ),
              ),
              SizedBox(
                height: size.height * 0.6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonRadius: 12,
                  buttonWidth: size.width,
                  buttonHeight: size.height * 0.08,
                  onClick: () {
                    Get.to(WelcomeView());
                  },
                  text: "next".tr,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
