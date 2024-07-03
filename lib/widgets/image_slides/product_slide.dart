import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/view_models/product_view_model.dart';

// ignore: must_be_immutable
class ProductSlide extends StatelessWidget {
  ProductSlide({
    required this.jsonProduct,
    required this.slideIndex,
    required this.onSlideChange,
    super.key,
  });

  HttpRequest httpRequest = HttpRequest();
  PageController pageCtrl = PageController();
  int slideIndex;
  Function onSlideChange;
  dynamic jsonProduct;
  List<Widget> itemSlider = [];
  List<String> imgLst = [];

  @override
  Widget build(BuildContext context) {
    getProductImages();
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: PageView(
              onPageChanged: (index) {
                onSlideChange(index);
              },
              controller: pageCtrl,
              children: itemSlider,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 5, bottom: 10),
            child: SmoothPageIndicator(
              controller: pageCtrl,
              count: imgLst.length,
              effect: const ScrollingDotsEffect(dotHeight: 10, dotWidth: 10, activeDotColor: ColorStyle.blueFav),
            ),
          ),
        ],
      ),
    );
  }

  getProductImages() async {
    List productImages = [];
    productImages = jsonProduct['images'];
    imgLst.clear();
    itemSlider.clear();
    for (var i = 0; i < productImages.length; i++) {
      imgLst.add(productImages[i]['src']);
    }
    itemSlider = imgLst
        .map(
          (item) => InkWell(
            child: CachedNetworkImage(imageUrl: item, fit: BoxFit.contain),
            onTap: () {
              ProductViewModel productViewModel = ProductViewModel();
              productViewModel.onTapProductImage(imageIndex: slideIndex, images: imgLst);
            },
          ),
        )
        .toList();
  }
}
