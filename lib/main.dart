import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:yad_sys/screens/main/main_screen.dart';
import 'package:yad_sys/screens/splash/splash_screen.dart';
import 'package:yad_sys/themes/dark_theme.dart';
import 'package:yad_sys/themes/light_theme.dart';
import 'package:yad_sys/themes/theme_provider.dart';
import 'package:yad_sys/tools/app_texts.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(), child: YademanSystemShop()));
}

class YademanSystemShop extends StatelessWidget {
  YademanSystemShop({super.key});

  @override
  Widget build(BuildContext context) {
    AppTexts appTextStrings = AppTexts();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTextStrings.appTitle,
      useInheritedMediaQuery: true,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: light,
      darkTheme: dark,
      routes: routes,
      home: const SplashScreen(),
    );
  }

  final Map<String, Widget Function(BuildContext)> routes = {
    'SplashScreen': (context) => const SplashScreen(),
    'MainScreen': (context) => const MainScreen(),
  };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
