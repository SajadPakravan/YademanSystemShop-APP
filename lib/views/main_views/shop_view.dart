import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/screens/main/shop/shop_filter_screen.dart';
import 'package:yad_sys/themes/color_style.dart';
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
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                titleSpacing: 0,
                toolbarHeight: 100,
                title: Column(
                  children: [const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Search()), filterBtn()],
                ),
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
                            ProductCardGrid(physics: const NeverScrollableScrollPhysics(), list: productsLst),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width / 3),
                              child: EasyButton(
                                type: EasyButtonType.text,
                                idleStateWidget: const Icon(Icons.more_horiz, color: Colors.red, size: 40),
                                loadingStateWidget: const Loading(),
                                onPressed: onMoreBtn,
                              ),
                            ),
                            const SizedBox(height: 10),
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
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      child: Row(
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
              children: [
                TextBodyMediumView(categoriesName[0], maxLines: 1),
                const Icon(Icons.arrow_drop_down, color: Colors.black54)
              ],
            ),
          ),
          TextButton(
            child: Row(
              children: [
                TextBodyMediumView(filterSave[0]["name"], maxLines: 1),
                const Icon(Icons.arrow_drop_down, color: Colors.black54)
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
    );
  }
}
