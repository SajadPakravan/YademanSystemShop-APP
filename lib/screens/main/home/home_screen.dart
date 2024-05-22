import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yad_sys/view_models/home/home_view_model.dart';
import 'package:yad_sys/views/home/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool visibleReloadCover = true;
  int slideIndex = 0;

  onSlideChange(index) {
    setState(() {
      slideIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    final homeModel = Provider.of<HomeViewModel>(context, listen: false);
    if (homeModel.laptopDetLst.isEmpty) {
      homeModel.loadData();
    }
  }

  onRefresh() async {
    final homeModel = Provider.of<HomeViewModel>(context, listen: false);
    homeModel.dataNumber = 1;
    homeModel.loadData();
    await Future<void>.delayed(const Duration(seconds: 10));
    setState(() => visibleReloadCover = false);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    setState(() => visibleReloadCover = true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, homeModel, child) {
      return HomeView(
        context: context,
        onRefresh: onRefresh,
        visibleReloadCover: visibleReloadCover,
        showContent: homeModel.showContent,
        slideIndex: slideIndex,
        onSlideChange: onSlideChange,
        offDetLst: homeModel.offDetLst,
        offImgLst: homeModel.offImgLst,
        categoriesLst: homeModel.categoriesLst,
        categoriesImgLst: homeModel.categoriesImgLst,
        laptopDetLst: homeModel.laptopDetLst,
        laptopImgLst: homeModel.laptopImgLst,
        speakerDetLst: homeModel.speakerDetLst,
        speakerImgLst: homeModel.speakerImgLst,
        internalDetLst: const [],
        internalImgLst: const [],
        storageDetLst: const [],
        storageImgLst: const [],
      );
    });
  }
}
