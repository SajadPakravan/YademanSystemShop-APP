import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/tools/app_function.dart';
import 'package:yad_sys/themes/app_themes.dart';

// ignore: must_be_immutable
class CategoriesView extends StatelessWidget {
  CategoriesView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.parentCategoriesLst,
    required this.parentCategoriesImgLst,
    required this.speakerSubCategoriesLst,
    required this.speakerSubCategoriesImgLst,
    required this.computerAccessoriesSubCategoriesLst,
    required this.computerAccessoriesSubCategoriesImgLst,
    required this.hardwareComputerSubCategoriesLst,
    required this.hardwareComputerSubCategoriesImgLst,
    required this.laptopAccessoriesSubCategoriesLst,
    required this.laptopAccessoriesSubCategoriesImgLst,
    required this.headphoneHandsfreeSubCategoriesLst,
    required this.headphoneHandsfreeSubCategoriesImgLst,
    required this.storageEquipmentSubCategoriesLst,
    required this.storageEquipmentSubCategoriesImgLst,
    required this.networkEquipmentSubCategoriesLst,
    required this.networkEquipmentSubCategoriesImgLst,
    required this.showContent,
  });

  BuildContext context;
  dynamic onRefresh;
  AppFunction appFun = AppFunction();
  List<ProductCategoryModel> parentCategoriesLst;
  List<ProductCategoryImage> parentCategoriesImgLst;
  List<ProductCategoryModel> speakerSubCategoriesLst;
  List<ProductCategoryImage> speakerSubCategoriesImgLst;
  List<ProductCategoryModel> computerAccessoriesSubCategoriesLst;
  List<ProductCategoryImage> computerAccessoriesSubCategoriesImgLst;
  List<ProductCategoryModel> hardwareComputerSubCategoriesLst;
  List<ProductCategoryImage> hardwareComputerSubCategoriesImgLst;
  List<ProductCategoryModel> laptopAccessoriesSubCategoriesLst;
  List<ProductCategoryImage> laptopAccessoriesSubCategoriesImgLst;
  List<ProductCategoryModel> headphoneHandsfreeSubCategoriesLst;
  List<ProductCategoryImage> headphoneHandsfreeSubCategoriesImgLst;
  List<ProductCategoryModel> storageEquipmentSubCategoriesLst;
  List<ProductCategoryImage> storageEquipmentSubCategoriesImgLst;
  List<ProductCategoryModel> networkEquipmentSubCategoriesLst;
  List<ProductCategoryImage> networkEquipmentSubCategoriesImgLst;
  bool showContent;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () {
            return onRefresh();
          },
          child: !showContent
              ? Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.black54,
                    size: width * 0.1,
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      parentCategories(),
                      subCategories(
                        title: "اسپیکر",
                        subCategoriesLst: speakerSubCategoriesLst,
                        subCategoriesImgLst: speakerSubCategoriesImgLst,
                      ),
                      subCategories(
                        title: "لوازم جانبی کامپیوتر",
                        subCategoriesLst: computerAccessoriesSubCategoriesLst,
                        subCategoriesImgLst: computerAccessoriesSubCategoriesImgLst,
                      ),
                      subCategories(
                        title: "سخت‌افزار کامپیوتر",
                        subCategoriesLst: hardwareComputerSubCategoriesLst,
                        subCategoriesImgLst: hardwareComputerSubCategoriesImgLst,
                      ),
                      subCategories(
                        title: "لوازم جانبی لپ‌تاپ",
                        subCategoriesLst: laptopAccessoriesSubCategoriesLst,
                        subCategoriesImgLst: laptopAccessoriesSubCategoriesImgLst,
                      ),
                      subCategories(
                        title: "هدفون و هندزفری",
                        subCategoriesLst: headphoneHandsfreeSubCategoriesLst,
                        subCategoriesImgLst: headphoneHandsfreeSubCategoriesImgLst,
                      ),
                      subCategories(
                        title: "تجهیزات ذخیره‌سازی",
                        subCategoriesLst: storageEquipmentSubCategoriesLst,
                        subCategoriesImgLst: storageEquipmentSubCategoriesImgLst,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  parentCategories() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 80,
          mainAxisSpacing: 20,
        ),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: parentCategoriesLst.length,
        itemBuilder: (BuildContext context, int index) {
          ProductCategoryModel categoryModel = parentCategoriesLst[index];
          ProductCategoryImage categoryImg = parentCategoriesImgLst[index];
          return InkWell(
            onTap: () {
              appFun.onTapShowAll(
                title: categoryModel.name.toString(),
                category: categoryModel.id.toString(),
              );
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: categoryImg.src.toString(),
                  errorWidget: (context, str, dyn) {
                    return const Icon(Icons.image, color: Colors.black26, size: 100);
                  },
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
    );
  }

  subCategories({
    required String title,
    required List subCategoriesLst,
    required List subCategoriesImgLst,
  }) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.all(10),
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          SizedBox(
            height: 130,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 80,
                mainAxisSpacing: 10,
              ),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: subCategoriesLst.length,
              itemBuilder: (BuildContext context, int index) {
                ProductCategoryModel categoryModel = subCategoriesLst[index];
                ProductCategoryImage categoryImg = subCategoriesImgLst[index];
                return InkWell(
                  onTap: () {
                    appFun.onTapShowAll(
                      title: categoryModel.name.toString(),
                      category: categoryModel.id.toString(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: categoryImg.src.toString(),
                          width: 70,
                          errorWidget: (context, str, dyn) {
                            return const Icon(Icons.image, color: Colors.black26, size: 100);
                          },
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
