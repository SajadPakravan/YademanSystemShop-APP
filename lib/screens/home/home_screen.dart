import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yad_sys/view_models/home/home_view_model.dart';
import 'package:yad_sys/views/home/home_view.dart';
import 'package:adivery/adivery.dart';
import 'package:adivery/adivery_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool visibleContent = true;
  int slideIndex = 0;

  onSlideChange(index) => setState(() => slideIndex = index);

  @override
  void initState() {
    super.initState();
    final homeModel = Provider.of<HomeViewModel>(context, listen: false);
    if (homeModel.laptopLst.isEmpty) homeModel.loadData();
    AdiveryPlugin.initialize('ad713526-f2d6-44fc-9eb6-64380f19ee11');
  }

  onRefresh() async {
    final homeModel = Provider.of<HomeViewModel>(context, listen: false);
    homeModel.dataNumber = 1;
    homeModel.loadData();
    await Future<void>.delayed(const Duration(seconds: 15));
    setState(() => visibleContent = false);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    setState(() => visibleContent = true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, homeModel, child) {
      return HomeView(
        context: context,
        onRefresh: onRefresh,
        visibleContent: visibleContent,
        showContent: homeModel.showContent,
        slideIndex: slideIndex,
        onSlideChange: onSlideChange,
        discountLst: homeModel.discountLst,
        categoriesLst: homeModel.categoriesLst,
        laptopLst: homeModel.laptopLst,
        speakerLst: homeModel.speakerLst,
        internalDetLst: const [],
        storageDetLst: const [],
        bannerAd: BannerAd(
          'ad713526-f2d6-44fc-9eb6-64380f19ee11',
          BannerAdSize.LARGE_BANNER,
          onAdLoaded: (ad) {
            print(58585588);
          },
          onAdClicked: (ad) {
            print(11111111);
          },
        ),
      );
    });
  }
}
