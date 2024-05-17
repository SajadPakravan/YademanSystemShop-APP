import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:yad_sys/screens/main/main_screen.dart';
import 'package:yad_sys/screens/splash/splash_screen.dart';
import 'package:yad_sys/themes/light_theme.dart';
import 'package:yad_sys/tools/app_texts.dart';

void main() {
  runApp(YademanSystemShop());
}

class YademanSystemShop extends StatelessWidget {
  YademanSystemShop({super.key});

  @override
  Widget build(BuildContext context) {
    AppTexts appTextStrings = AppTexts();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTextStrings.appTitle,
      useInheritedMediaQuery: true,
      theme: appTheme,
      routes: routes,
      home: const SplashScreen(),
    );
  }

  final Map<String, Widget Function(BuildContext)> routes = {
    'SplashScreen': (context) => const SplashScreen(),
    'MainScreen': (context) => const MainScreen(),
  };
}
