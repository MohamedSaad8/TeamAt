import 'dart:ui';
import 'package:get/get.dart';
import 'package:team_at/helper/local_storage_helper/language_local_storage.dart';

class AppLanguageViewModel extends GetxController {
  var currentAppLanguage = "ar" ;

  @override
  void onInit() async {
    super.onInit();
     LanguageLocalStorage languageLocalStorage = LanguageLocalStorage();

    currentAppLanguage = (await languageLocalStorage.selectedLanguage) == null
        ? "ar"
        :await languageLocalStorage.selectedLanguage;
    Get.updateLocale(Locale(currentAppLanguage));
    update();

  }

  void changeSelectedLanguage(String language) async {
    LanguageLocalStorage languageLocalStorage = LanguageLocalStorage();
    if (await languageLocalStorage.selectedLanguage == language)
      {
        print("equal");
        return;
      }
    else {
      currentAppLanguage = language;
      languageLocalStorage.saveLanguageToDisk(language);
      print("saved on the disk");
    }
    update();
  }
}
