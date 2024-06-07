import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/screens/main/shop/shop_filter_screen.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/themes/app_themes.dart';
import 'package:yad_sys/widgets/cards/product_card_grid.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/search.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

// ignore: must_be_immutable
class ShopView extends StatelessWidget {
  ShopView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.visibleReloadCover,
    required this.scrollController,
    required this.productsLst,
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
  List<ProductModel> productsLst;
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
              SliverAppBar(
                title: Column(
                  children: [const Search(), filterBtn()],
                ),
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0,
                titleSpacing: 10,
                toolbarHeight: 90,
              ),
            ],
            body: productsLst.isEmpty
                ? const Loading()
                : Visibility(
                    visible: visibleReloadCover,
                    child: RefreshIndicator(
                      onRefresh: () => onRefresh(),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ProductCardGrid(physics: const NeverScrollableScrollPhysics(), list: productsLst),
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
    );
  }

  filterBtn() {
    return Row(
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
            children: [TextBodyMediumView(categoriesName[0], maxLines: 1), const Icon(Icons.arrow_drop_down, color: Colors.black54)],
          ),
        ),
        TextButton(
          child: Row(
            children: [TextBodyMediumView(filterSave[0]["name"], maxLines: 1), const Icon(Icons.arrow_drop_down, color: Colors.black54)],
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
    );
  }
}
