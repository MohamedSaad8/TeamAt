import 'package:get_storage/get_storage.dart';

class LanguageLocalStorage
{
  ///write
  void saveLanguageToDisk(String selectedLanguage) async
  {
    await GetStorage().write("appLang", selectedLanguage);
  }

  ///read
  Future<String> get  selectedLanguage async {
    return  await GetStorage().read("appLang");
  }
}