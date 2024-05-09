import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/screens/main/main_screen.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/views/main_views/shop_view.dart';
import 'package:yad_sys/widgets/app_dialogs.dart';

// ignore: must_be_immutable
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => ShopScreenState();
}

class ShopScreenState extends State<ShopScreen> {
  MainScreen mainScreen = const MainScreen();
  HttpRequest httpRequest = HttpRequest(context: Get.context!);
  AppDialogs appDialogs = AppDialogs();
  AppTexts appTexts = AppTexts();
  bool visibleReloadCover = true;
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool moreProduct = false;
  List<ProductModel> productsDetLst = [];
  List<Images> productsImgLst = [];
  List<ProductCategoryModel> categoriesLst = [];
  List<String> categoriesName = [];
  List<String> categoriesId = [];
  Map<String, List<String>> categoriesSave = {};
  List<Map<String, dynamic>> filtersLst = [];
  String order = "desc";
  String orderby = "date";
  String onSale = "";
  List<Map<String, dynamic>> filterSave = [];
  double appBarHeight = 50;
  double appBarHeightBtnRotate = 0;

  onTapAppbarHeight() {
    setState(() {
      appBarHeight = appBarHeight == 50 ? 120 : 50;
      appBarHeightBtnRotate = appBarHeightBtnRotate == 0 ? 0.5 : 0;
    });
  }

  loadCategories(categories) {
    if (categories != null && !categories.toString().contains(categoriesSave.toString())) {
      if (kDebugMode) {
        print("Different categories >>>> \ncategories >> $categories \ncategoriesSave >> $categoriesSave");
      }
      setState(() {
        categoriesName = categories["categoriesName"];
        categoriesId = categories["categoriesId"];
        categoriesSave = categories;
        page = 1;
        productsDetLst.clear();
        productsImgLst.clear();
      });
      getProducts();
      if (kDebugMode) {
        print("Save Categories >>>> \ncategories >> $categories \ncategoriesSave >> $categoriesSave");
      }
    }
  }

  loadFilters(filterIndex) {
    if (filterIndex != null && !filterSave.contains(filtersLst[filterIndex])) {
      if (kDebugMode) {
        print("Different filter >>>> \nfilter >> ${filtersLst[filterIndex]} \nfilterSave >> $filterSave");
      }
      setState(() {
        filterSave.clear();
        filterSave.add(filtersLst[filterIndex]);
        page = 1;
        order = filtersLst[filterIndex]["order"];
        orderby = filtersLst[filterIndex]["orderby"];
        productsDetLst.clear();
        productsImgLst.clear();
      });
      if (filtersLst[filterIndex].containsKey("onSale")) {
        onSale = "true";
      } else {
        onSale = "";
      }
      getProducts();
      if (kDebugMode) {
        print("Save Filter >>>> \nfilter >> ${filtersLst[filterIndex]} \nfilterSave >> $filterSave");
      }
    }
  }

  getProducts() async {
    dynamic jsonGetProducts = await httpRequest.getProducts(
      page: page,
      category: categoriesId.toString().replaceAll(RegExp(r'[^0-9,]'), ''),
      order: order,
      orderby: orderby,
      onSale: onSale,
    );

    List jsonProductsImage = [];
    List<Images> pImage = [];
    jsonGetProducts.forEach((i) {
      jsonProductsImage.add(i['images'][0]);
    });
    for (var image in jsonProductsImage) {
      setState(() {
        pImage.add(Images(src: image['src']));
      });
    }
    if(!moreProduct) {
      productsImgLst.clear();
    }
    productsImgLst.addAll(pImage);

    List<ProductModel> pDetails = [];
    jsonGetProducts.forEach((p) {
      setState(() {
        pDetails.add(
          ProductModel(
            id: p['id'],
            name: p['name'],
            regularPrice: p['regular_price'],
            salePrice: p['sale_price'],
          ),
        );
      });
    });
    if(!moreProduct) {
      productsDetLst.clear();
    }
    productsDetLst.addAll(pDetails);
    setState(() {
      moreProduct = false;
    });
  }

  getParentCategoriesFilters() async {
    setState(() {
      categoriesName = [appTexts.allCategories];
      categoriesSave = {"categoriesName": categoriesName, "categoriesId": categoriesId};
      filtersLst.add({"name": appTexts.newest, "order": order, "orderby": orderby, "select": true});
      filtersLst.add({"name": appTexts.oldest, "order": "asc", "orderby": "date", "select": false});
      filtersLst.add({
        "name": appTexts.off,
        "order": "desc",
        "orderby": "date",
        "onSale": true,
        "select": false,
      });
      filtersLst.add({"name": appTexts.expensive, "order": "desc", "orderby": "price", "select": false});
      filtersLst.add({"name": appTexts.cheapest, "order": "asc", "orderby": "price", "select": false});
      filtersLst.add({"name": appTexts.popular, "order": "desc", "orderby": "popularity", "select": false});
      filtersLst.add({"name": appTexts.score, "order": "desc", "orderby": "rating", "select": false});
      filterSave.add(filtersLst[0]);
    });
    dynamic jsonGetCategories = await httpRequest.getCategories(perPage: 100);
    jsonGetCategories.forEach((pc) {
      setState(() {
        categoriesLst.add(
          ProductCategoryModel(id: pc['id'], name: pc['name'], select: false),
        );
      });
    });
  }

  // scrollListener() {
  //   if (scrollController.offset >= scrollController.position.maxScrollExtent && !moreProduct) {
  //     setState(() {
  //       moreProduct = true;
  //       page++;
  //     });
  //     getProducts();
  //   }
  // }

  onMoreBtn() {
    if(!moreProduct) {
      setState(() {
        moreProduct = true;
        page++;
      });
      getProducts();
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getParentCategoriesFilters();
    // scrollController.addListener(scrollListener);
  }

  onRefresh() async {
    setState(() {
      page = 1;
    });
    getProducts();
    await Future<void>.delayed(const Duration(seconds: 3));
    setState(() {
      visibleReloadCover = false;
    });
    await Future<void>.delayed(const Duration(milliseconds: 200));
    setState(() {
      visibleReloadCover = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShopView(
      context: context,
      onRefresh: onRefresh,
      visibleReloadCover: visibleReloadCover,
      scrollController: scrollController,
      productsDetLst: productsDetLst,
      productsImgLst: productsImgLst,
      moreProduct: moreProduct,
      categoriesLst: categoriesLst,
      filtersLst: filtersLst,
      categoriesName: categoriesName,
      loadCategories: loadCategories,
      filterSave: filterSave,
      loadFilters: loadFilters,
      appBarHeight: appBarHeight,
      appBarHeightBtnRotate: appBarHeightBtnRotate,
      onTapAppbarHeight: onTapAppbarHeight,
      onMoreBtn: onMoreBtn,
    );
  }
}
