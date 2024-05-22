import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/screens/main/shop/shop_filter_screen.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/themes/app_themes.dart';
import 'package:yad_sys/widgets/cards/product_card_grid.dart';
import 'package:yad_sys/widgets/search_bar.dart';

// ignore: must_be_immutable
class ShopView extends StatelessWidget {
  ShopView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.visibleReloadCover,
    required this.scrollController,
    required this.productsDetLst,
    required this.productsImgLst,
    required this.moreProduct,
    required this.categoriesLst,
    required this.filtersLst,
    required this.categoriesName,
    required this.loadCategories,
    required this.filterSave,
    required this.loadFilters,
    required this.appBarHeight,
    required this.appBarHeightBtnRotate,
    required this.onTapAppbarHeight,
    required this.onMoreBtn,
  });

  BuildContext context;
  AppDimension appDimension = AppDimension();
  dynamic onRefresh;
  bool visibleReloadCover;
  ScrollController scrollController;
  List<ProductModel> productsDetLst;
  List<Images> productsImgLst;
  bool moreProduct;
  List<ProductCategoryModel> categoriesLst;
  List<Map<String, dynamic>> filtersLst;
  List<String> categoriesName;
  List<Map<String, dynamic>> filterSave;
  Function loadCategories;
  Function loadFilters;
  double appBarHeight;
  double appBarHeightBtnRotate;
  Function onTapAppbarHeight;
  Function onMoreBtn;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(
                title: SearchNav(),
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0,
                titleSpacing: 10,
              ),
            ],
            body: Center(
              child: productsDetLst.isEmpty
                  ? LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black54,
                      size: width * 0.1,
                    )
                  : Visibility(
                      visible: visibleReloadCover,
                      child: Scaffold(
                        appBar: filterBtn(),
                        body: RefreshIndicator(
                          onRefresh: () {
                            return onRefresh();
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ProductCardGrid(
                                    listDetails: productsDetLst,
                                    listImage: productsImgLst,
                                    physics: const NeverScrollableScrollPhysics(),
                                  ),
                                ),
                                moreProduct
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: LoadingAnimationWidget.threeArchedCircle(
                                          color: Colors.black54,
                                          size: width * 0.1,
                                        ),
                                      )
                                    : ElevatedButton.icon(
                                        onPressed: () {
                                          onMoreBtn();
                                        },
                                        icon: const Icon(Icons.more_horiz_rounded),
                                        label: Text(
                                          "بیشتر",
                                          style: Theme.of(context).textTheme.buttonText1,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  filterShow() {
    double width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: categoriesName.length > 1 ? true : false,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: categoriesName.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorStyle.blueFav,
                borderRadius: BorderRadius.all(Radius.circular(width)),
              ),
              child: AutoSizeText(
                categoriesName[index],
                style: Theme.of(context).textTheme.buttonText1,
                maxLines: 1,
                minFontSize: appDimension.textNormal,
                maxFontSize: appDimension.textNormal,
              ),
            );
          },
        ),
      ),
    );
  }

  filterBtn() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: categoriesName.length == 1 ? 50 : appBarHeight,
          alignment: Alignment.center,
          child: Material(
            color: Colors.white,
            elevation: 3,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: categoriesLst.isEmpty
                                ? null
                                : () async {
                                    final categories = await Get.to(
                                      ShopFilterScreen(categoriesLst: categoriesLst),
                                      transition: Transition.upToDown,
                                      duration: const Duration(milliseconds: 500),
                                      arguments: {"categoriesName": categoriesName, "filterName": null},
                                    );
                                    loadCategories(categories);
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  categoriesName[0],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  maxFontSize: 14,
                                  minFontSize: 14,
                                ),
                                Visibility(
                                  visible: categoriesName.length > 1 ? true : false,
                                  child: Text(
                                    " + ${(categoriesName.length - 1).toString().toPersianDigit()}",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            child: Row(
                              children: [
                                AutoSizeText(
                                  filterSave[0]["name"],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  maxFontSize: 14,
                                  minFontSize: 14,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              final filterIndex = await Get.to(
                                ShopFilterScreen(filtersLst: filtersLst),
                                transition: Transition.upToDown,
                                duration: const Duration(milliseconds: 500),
                                arguments: {"filterSave": filterSave, "categoriesName": null},
                              );
                              loadFilters(filterIndex);
                            },
                          ),
                        ],
                      ),
                      filterShow(),
                    ],
                  ),
                ),
                btnHeight(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  btnHeight() {
    double width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: categoriesName.length > 1 ? true : false,
      child: Transform.translate(
        offset: const Offset(0, 17),
        child: InkWell(
          onTap: () {
            onTapAppbarHeight();
          },
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: ColorStyle.blueFav,
              borderRadius: BorderRadius.all(Radius.circular(width)),
            ),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: appBarHeightBtnRotate,
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
