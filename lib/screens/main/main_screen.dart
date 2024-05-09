import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yad_sys/screens/main/categories/categories_screen.dart';
import 'package:yad_sys/screens/main/home/home_screen.dart';
import 'package:yad_sys/screens/main/profile/account_screen.dart';
import 'package:yad_sys/screens/main/shop/shop_screen.dart';
import 'package:yad_sys/tools/app_themes.dart';
import 'package:yad_sys/view_models/main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  MainViewModel mainScrModel = MainViewModel();
  PageController pageCtrl = PageController();
  int pageIndex = 0;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.white));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: const [
            HomeScreen(),
            ShopScreen(),
            CategoriesScreen(),
            AccountScreen(),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  bottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedLabelStyle: Theme.of(context).textTheme.menu,
        selectedLabelStyle: Theme.of(context).textTheme.menu,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        onTap: (index) => setState(() {
          mainScrModel.onTapMenu(index: index);
          setState(() {
            pageIndex = index;
          });
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(mainScrModel.icnHome),
            label: "خانه",
          ),
          BottomNavigationBarItem(
            icon: Icon(mainScrModel.icnShop),
            label: "فروشگاه",
          ),
          BottomNavigationBarItem(
            icon: Icon(mainScrModel.icnCategory),
            label: "دسته‌بندی‌ها",
          ),
          BottomNavigationBarItem(
            icon: Icon(mainScrModel.icnAccount),
            label: "حساب من",
          ),
        ],
      ),
    );
  }
}
