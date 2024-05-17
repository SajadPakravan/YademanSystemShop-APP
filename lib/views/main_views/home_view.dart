import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_function.dart';
import 'package:yad_sys/tools/app_themes.dart';
import 'package:yad_sys/widgets/cards/home_menu.dart';
import 'package:yad_sys/widgets/cards/product_card_horizontal.dart';
import 'package:yad_sys/widgets/cards/product_image_card.dart';
import 'package:yad_sys/widgets/image_slides/home_slide.dart';
import 'package:yad_sys/widgets/image_slides/image_banner.dart';
import 'package:yad_sys/widgets/search_bar.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({
    required this.context,
    required this.onRefresh,
    required this.visibleReloadCover,
    required this.showContent,
    required this.slideIndex,
    required this.onSlideChange,
    required this.offDetLst,
    required this.offImgLst,
    required this.categoriesLst,
    required this.categoriesImgLst,
    required this.laptopDetLst,
    required this.laptopImgLst,
    required this.speakerDetLst,
    required this.speakerImgLst,
    required this.internalDetLst,
    required this.internalImgLst,
    required this.storageDetLst,
    required this.storageImgLst,
    super.key,
  });

  AppFunction appFun = AppFunction();
  BuildContext context;
  bool showContent;
  int slideIndex;
  Function onSlideChange;
  dynamic onRefresh;
  bool visibleReloadCover;
  List<ProductModel> offDetLst;
  List<Images> offImgLst;
  List<ProductCategoryModel> categoriesLst;
  List<ProductCategoryImage> categoriesImgLst;
  List<ProductModel> laptopDetLst;
  List<Images> laptopImgLst;
  List<ProductModel> speakerDetLst;
  List<Images> speakerImgLst;
  List<ProductModel> internalDetLst;
  List<Images> internalImgLst;
  List<ProductModel> storageDetLst;
  List<Images> storageImgLst;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              elevation: 3,
              titleSpacing: 10,
              title: SearchNav(),
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () {
              return onRefresh();
            },
            child: showContent
                ? homeContent()
                : Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black54,
                      size: width * 0.1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  homeContent() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Visibility(
      visible: visibleReloadCover,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HomeSlide(slideIndex: slideIndex, onSlideChange: onSlideChange),
            Container(margin: EdgeInsets.only(bottom: height * 0.03), child: HomeMenu(context: context)),
            offProducts(
              listDetails: offDetLst,
              listImage: offImgLst,
            ),
            parentCategories(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              margin: EdgeInsets.only(bottom: height * 0.03),
              child: InkWell(
                onTap: () {},
                child: ImageBanner(image: "https://yademansystem.ir/assets/images/banners/YademanSystem_banner_laptop.jpg"),
              ),
            ),
            productsOfCategoryImage(
              titleCatalog: "لپ‌تاپ",
              listDet: laptopDetLst,
              listImage: laptopImgLst,
              categoryId: 57,
            ),
            productsOfCategoryImage(
              titleCatalog: "اسپیکر",
              listDet: speakerDetLst,
              listImage: speakerImgLst,
              categoryId: 153,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              margin: EdgeInsets.only(bottom: height * 0.03),
              child: InkWell(
                onTap: () {},
                child: ImageBanner(image: "https://yademansystem.ir/assets/images/banners/YademanSystem_banner_speaker.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  offProducts({
    required List listDetails,
    required List listImage,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Visibility(
      visible: listDetails.isEmpty ? false : true,
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.03),
        padding: EdgeInsets.symmetric(vertical: width * 0.03),
        color: const Color.fromRGBO(49, 123, 218, 1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                height: 290,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/images/amazings.svg",
                      fit: BoxFit.contain,
                      width: width * 0.25,
                    ),
                    Image.asset(
                      "assets/images/box.webp",
                      fit: BoxFit.contain,
                      width: width * 0.3,
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Text(
                            "مشاهده همه",
                            style: Theme.of(context).textTheme.buttonText1,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: width * 0.03),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        appFun.onTapShowAll(title: "پیشنهاد شگفت‌انگیز", onSale: "true");
                      },
                    )
                  ],
                ),
              ),
              ProductCardHorizontal(
                listDetails: listDetails,
                listImage: listImage,
                physics: const NeverScrollableScrollPhysics(),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "مشاهده همه",
                        style: Theme.of(context).textTheme.buttonText1,
                      ),
                      const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  appFun.onTapShowAll(title: "پیشنهاد شگفت‌انگیز", onSale: "true");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  parentCategories() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.03),
      child: Column(
        children: [
          Text(
            "خرید بر اساس دسته‌بندی",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Container(
            margin: EdgeInsets.only(top: width * 0.02),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(width * 0.03),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: width * 0.0025,
                crossAxisSpacing: width * 0.02,
                mainAxisSpacing: width * 0.04,
              ),
              itemCount: categoriesLst.length,
              itemBuilder: (BuildContext context, int index) {
                ProductCategoryModel categoryModel = categoriesLst[index];
                ProductCategoryImage categoryImg = categoriesImgLst[index];
                return InkWell(
                  onTap: () {
                    appFun.onTapShowAll(
                      title: categoryModel.name.toString(),
                      category: categoryModel.id.toString(),
                    );
                  },
                  child: Column(
                    children: [
                      FittedBox(
                        child: CachedNetworkImage(
                          imageUrl: categoryImg.src.toString(),
                          height: 65,
                          width: 65,
                          errorWidget: (context, str, dyn) {
                            return const Icon(Icons.image, color: Colors.black26, size: 100);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: width * 0.2,
                        child: AutoSizeText(
                          categoryModel.name.toString(),
                          style: Theme.of(context).textTheme.homeMenu,
                          textAlign: TextAlign.center,
                          minFontSize: 12,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  productsOfCategoryImage({
    required String titleCatalog,
    required List listDet,
    required List listImage,
    required int categoryId,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.03),
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            margin: EdgeInsets.only(bottom: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.02),
                      child: const Icon(Icons.pix_rounded, color: ColorStyle.blueFav, size: 20),
                    ),
                    Text(
                      titleCatalog,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                InkWell(
                  child: Text(
                    "مشاهده همه",
                    style: Theme.of(context).textTheme.txtBtnBlue,
                  ),
                  onTap: () {
                    appFun.onTapShowAll(title: titleCatalog, category: categoryId.toString());
                  },
                ),
              ],
            ),
          ),
          ProductImageCard(
            listDet: listDet,
            listImage: listImage,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }

// productsOfCategory({
//   required String titleCategory,
//   required List listDetails,
//   required List listImage,
//   required int categoryId,
// }) {
//   double width = MediaQuery.of(context).size.width;
//   double height = MediaQuery.of(context).size.height;
//   return Container(
//     margin: EdgeInsets.only(bottom: height * 0.03),
//     padding: EdgeInsets.symmetric(vertical: width * 0.02),
//     child: Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.03),
//           margin: EdgeInsets.only(bottom: width * 0.04),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: width * 0.02),
//                     child: const Icon(
//                       Icons.pix_rounded,
//                       color: Color.fromRGBO(6, 82, 221, 1.0),
//                       size: 20,
//                     ),
//                   ),
//                   Text(
//                     titleCategory,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//               InkWell(
//                 child: Text(
//                   "مشاهده همه",
//                   style: Theme.of(context).textTheme.txtBtnBlue,
//                 ),
//                 onTap: () {
//                   appFun.onTapShowAll(title: titleCategory, id: categoryId.toString());
//                 },
//               ),
//             ],
//           ),
//         ),
//         ProductCard(listDetails: listDetails, listImage: listImage),
//       ],
//     ),
//   );
// }
}
