import 'package:get/get.dart';
import 'helper/app_languages_helper/ar.dart';
import 'helper/app_languages_helper/en.dart';

class Translation extends Translations
{
  @override
  Map<String, Map<String, String>> get keys => {
    "ar" : ar,
    "en" : en
  };
}