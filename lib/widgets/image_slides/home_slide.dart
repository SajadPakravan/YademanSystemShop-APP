import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yad_sys/tools/app_colors.dart';

// ignore: must_be_immutable
class HomeSlide extends StatelessWidget {
  HomeSlide({
    Key? key,
    required this.slideIndex,
    required this.onSlideChange,
  }) : super(key: key);

  AppColors appColors = AppColors();
  final PageController _pageCtrl = PageController();
  int slideIndex;
  Function onSlideChange;
  bool forwardSlide = true;

  List<String> imgLst = [
    "https://yademansystem.ir/assets/images/banners/YademanSystem_banner_laptop.jpg",
    "https://yademansystem.ir/assets/images/banners/YademanSystem_banner_speaker.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    List<Widget> itemSlider = imgLst
        .map(
          (item) => InkWell(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(imageUrl: item, fit: BoxFit.fitHeight))),
            onTap: () {},
          ),
        )
        .toList();

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.03),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 0,
            child: PageView(
              controller: _pageCtrl,
              children: itemSlider,
            ),
          ),
          CarouselSlider(
            items: itemSlider,
            options: CarouselOptions(
                height: 180,
                viewportFraction: 0.9,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, value) {
                  onSlideChange(index);
                  _pageCtrl.animateToPage(
                    slideIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                }),
          ),
          Transform.translate(
            offset: const Offset(30, 70),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 5),
              child: SmoothPageIndicator(
                controller: _pageCtrl,
                count: imgLst.length,
                effect: const ScrollingDotsEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
