import 'package:flutter/material.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:get/get.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/widgets/select_categories.dart';
import 'package:yad_sys/widgets/cards/product_card_grid.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/search.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class ShopView extends StatelessWidget {
  ShopView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.visibleReloadCover,
    required this.productsLst,
    required this.moreProduct,
    required this.categoriesLst,
    required this.categoriesName,
    required this.categoriesId,
    required this.filterSave,
    required this.onMoreBtn,
  });

  final BuildContext context;
  final AppDimension appDimension = AppDimension();
  final dynamic onRefresh;
  final bool visibleReloadCover;
  final List<ProductModel> productsLst;
  final bool moreProduct;
  final List<ProductCategoryModel> categoriesLst;
  final List<String> categoriesName;
  final List<int> categoriesId;
  final List<Map<String, dynamic>> filterSave;
  final Function onMoreBtn;

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
                    var result = selectCategories(context: context, categoriesLst: categoriesLst);
                    print(result);
                  },
            child: const Row(
              children: [TextBodyMediumView('دسته‌بندی‌ها', maxLines: 1), Icon(Icons.arrow_drop_down, color: Colors.black54)],
            ),
          ),
          TextButton(
            child: Row(
              children: [
                TextBodyMediumView(filterSave[0]['name'], maxLines: 1),
                const Icon(Icons.arrow_drop_down, color: Colors.black54)
              ],
            ),
            onPressed: () {
              // final filterIndex = await Get.to(
              //   ShopFilterScreen(filtersLst: filtersLst),
              //   transition: Transition.upToDown,
              //   duration: const Duration(milliseconds: 500),
              //   arguments: {"filterSave": filterSave, "categoriesName": null},
              // );
              // loadFilters(filterIndex);
            },
          ),
        ],
      ),
    );
  }
}
