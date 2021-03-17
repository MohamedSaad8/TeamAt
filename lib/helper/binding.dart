import 'package:get/get.dart';
import 'package:team_at/viewModel/app_langauge_viewModel.dart';
import 'local_storage_helper/language_local_storage.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'package:team_at/viewModel/controlHomeViewModel.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/viewModel/group_view_model.dart';

class Binding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageLocalStorage());
    Get.lazyPut(() => AppLanguageViewModel());
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlHomeViewModel());
    Get.lazyPut(() => PostsViewModel());
    Get.lazyPut(() => GroupViewModel());
  }

}