import 'package:get/get.dart';
import 'package:team_at/viewModel/app_langauge_viewModel.dart';
import 'local_storage_helper/language_local_storage.dart';

class Binding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageLocalStorage());
    Get.lazyPut(() => AppLanguageViewModel());
  }

}