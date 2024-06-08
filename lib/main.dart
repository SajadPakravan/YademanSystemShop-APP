import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/screens/connection_error.dart';
import 'package:yad_sys/screens/main/main_screen.dart';
import 'package:yad_sys/screens/splash/splash_screen.dart';
import 'package:yad_sys/themes/theme.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/view_models/home/home_view_model.dart';
import 'package:yad_sys/view_models/shop/shop_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ShopViewModel()),
        ChangeNotifierProvider(create: (_) => ProductCategoryModel()),
      ],
      child: const YademanSystemShop(),
    ),
  );
}

class YademanSystemShop extends StatefulWidget {
  const YademanSystemShop({super.key});

  @override
  State<YademanSystemShop> createState() => _YademanSystemShop();
}

class _YademanSystemShop extends State<YademanSystemShop> {
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
    'ConnectionError': (context) => const ConnectionError(),
    'SplashScreen': (context) => const SplashScreen(),
    'MainScreen': (context) => const MainScreen(),
  };
}
