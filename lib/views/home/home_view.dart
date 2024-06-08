import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_function.dart';
import 'package:yad_sys/widgets/cards/home_menu.dart';
import 'package:yad_sys/widgets/cards/product_card_horizontal.dart';
import 'package:yad_sys/widgets/cards/product_image_card.dart';
import 'package:yad_sys/widgets/image_slides/home_slide.dart';
import 'package:yad_sys/widgets/image_slides/image_banner.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/search.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class HomeView extends StatelessWidget {
  HomeView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.visibleContent,
    required this.showContent,
    required this.slideIndex,
    required this.onSlideChange,
    required this.discountLst,
    required this.categoriesLst,
    required this.laptopLst,
    required this.speakerLst,
    required this.internalDetLst,
    required this.storageDetLst,
  });

  final AppFunction appFun = AppFunction();
  final BuildContext context;
  final bool showContent;
  final int slideIndex;
  final Function onSlideChange;
  final Function onRefresh;
  final bool visibleContent;
  final List<ProductModel> discountLst;
  final List<ProductCategoryModel> categoriesLst;
  final List<ProductModel> laptopLst;
  final List<ProductModel> speakerLst;
  final List<ProductModel> internalDetLst;
  final List<ProductModel> storageDetLst;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              titleSpacing: 10,
              title: Search(),
            ),
          ],
          body: RefreshIndicator(onRefresh: () => onRefresh(), child: showContent ? homeContent() : const Loading()),
        ),
      ),
    );
  }

  homeContent() {
    return Visibility(
      visible: visibleContent,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HomeSlide(slideIndex: slideIndex, onSlideChange: onSlideChange),
            const SizedBox(height: 20),
            const HomeMenu(),
            const SizedBox(height: 10),
            discountProducts(list: discountLst),
            parentCategories(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {},
                child: ImageBanner(image: "https://yademansystem.ir/assets/images/banners/YademanSystem_banner_laptop.png"),
              ),
            ),
            const SizedBox(height: 20),
            productsOfCategoryImage(titleCategory: "لپ‌تاپ", list: laptopLst, categoryId: 57),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {},
                child: ImageBanner(image: "https://yademansystem.ir/assets/images/banners/YademanSystem_banner_speaker.png"),
              ),
            ),
            const SizedBox(height: 20),
            productsOfCategoryImage(titleCategory: "اسپیکر", list: speakerLst, categoryId: 153),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  discountProducts({required List list}) {
    double width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: list.isEmpty ? false : true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: const Color.fromRGBO(49, 123, 218, 1),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 290,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/amazings.svg", fit: BoxFit.contain, width: width * 0.25),
                  Image.asset("assets/images/box.webp", fit: BoxFit.contain, width: width * 0.3),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: width * 0.33),
                  ProductCardHorizontal(physics: const NeverScrollableScrollPhysics(), list: discountLst),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ColorStyle.blueFav),
                      elevation: MaterialStateProperty.all(10),
                    ),
                    child: const TextBodyMediumView('مشاهده همه', color: Colors.white),
                    onPressed: () => appFun.onTapShowAll(title: "پیشنهاد شگفت‌انگیز", onSale: "true"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  parentCategories() {
    return Column(
      children: [
        const TextBodyLargeView("خرید بر اساس دسته‌بندی"),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: categoriesLst.length,
            itemBuilder: (BuildContext context, int index) {
              ProductCategoryModel category = categoriesLst[index];
              ProductCategoryImage img = category.image!;
              return InkWell(
                onTap: () => appFun.onTapShowAll(title: category.name!, category: category.id.toString()),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: img.src!,
                      width: 80,
                      errorWidget: (context, str, dyn) => const Icon(Icons.image, color: Colors.black26, size: 100),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextBodyMediumView(category.name!, textAlign: TextAlign.center, maxLines: 2),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  productsOfCategoryImage({required String titleCategory, required List<ProductModel> list, required int categoryId}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      minVerticalPadding: 0,
      title: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: ColorStyle.blueFav,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: TextBodyLargeView(titleCategory, color: Colors.white),
      ),
      subtitle: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
            child: ProductImageCard(physics: const NeverScrollableScrollPhysics(), list: list),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.deepPurple, ColorStyle.blueFav]),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 10),
                  TextBodyMediumView('مشاهده همه', color: Colors.white, textAlign: TextAlign.center),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
            onTap: () => appFun.onTapShowAll(title: titleCategory, category: categoryId.toString()),
          ),
        ],
      ),
    );
  }
}
