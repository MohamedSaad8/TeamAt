import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:team_at/translation.dart';
import 'package:team_at/view/app_language_view.dart';
import 'package:team_at/widget/teamAt_splash_screen.dart';
import 'package:flutter/services.dart';
import 'helper/binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("GetStorage");
  await Firebase.initializeApp();
 SystemChrome.setPreferredOrientations(
     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
        title: 'Team At ',
        initialBinding: Binding(),
        locale: Locale("en"),
        fallbackLocale: Locale("en") ,
        translations: Translation(),
        home: TeamAtSplashScreen(
          nextScreen: AppLanguageView(),
        ),
      ),
    );
  }
}


