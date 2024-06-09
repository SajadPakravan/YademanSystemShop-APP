import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/views/main_views/shop_view.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => ShopScreenState();
}

class ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  HttpRequest httpRequest = HttpRequest();
  List<ProductModel> productsLst = [];
  List<ProductCategoryModel> categoriesLst = [];
  List<int> categoriesId = [];
  bool visibleReloadCover = true;
  int page = 1;
  bool moreProduct = false;
  Map<String, List<String>> categoriesSave = {};
  List<Map<String, dynamic>> filtersLst = [];
  String order = 'desc';
  String orderBy = 'date';
  String onSale = '';
  List<Map<String, dynamic>> filterSave = [];
  int productCount = 0;

  getCategories(categories) {
    if (categories != null && !categories.toString().contains(categoriesSave.toString())) {
      if (kDebugMode) {
        print("Different categories >>>> \ncategories >> $categories \ncategoriesSave >> $categoriesSave");
      }
      setState(() {
        categoriesId = categories["categoriesId"];
        categoriesSave = categories;
        page = 1;
        productsLst.clear();
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
        orderBy = filtersLst[filterIndex]["orderby"];
        productsLst.clear();
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
    if (!moreProduct) {
      setState(() {
        productsLst.clear();
        page = 1;
      });
    }
    dynamic jsonProducts = await httpRequest.getProducts(
      page: page,
      category: categoriesId.isEmpty ? '' : categoriesId.toString().replaceAll(RegExp(r'[^0-9,]'), ''),
      order: order,
      orderBy: orderBy,
      onSale: onSale,
    );
    setState(() => productCount = 0);
    jsonProducts.forEach((p) {
      productsLst.add(ProductModel.fromJson(p));
      setState(() => productCount++);
    });
    setState(() => moreProduct = false);
  }

  getParentCategoriesFilters() async {
    setState(() {
      filtersLst.add({'name': 'جدیدترین', 'order': order, 'orderby': orderBy, 'select': true});
      filtersLst.add({'name': 'قدیمی‌ترین', 'order': 'asc', 'orderby': 'date', 'select': false});
      filtersLst.add({'name': 'تخفیف خورده', 'order': 'desc', 'orderby': 'date', 'onSale': true, 'select': false});
      filtersLst.add({"name": 'گران‌ترین', "order": "desc", 'orderby': "price", "select": false});
      filtersLst.add({"name": 'ارزان ترین', "order": "asc", "orderby": "price", "select": false});
      filtersLst.add({"name": 'محبوب‌ترین', "order": "desc", "orderby": "popularity", "select": false});
      filtersLst.add({"name": 'بالاترین امتیاز', "order": "desc", "orderby": "rating", "select": false});
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

  onMoreBtn() async {
    if (!moreProduct) {
      setState(() {
        moreProduct = true;
        page++;
      });
      getProducts();
    }
    await Future<void>.delayed(const Duration(seconds: 5));
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getParentCategoriesFilters();
  }

  onRefresh() async {
    getProducts();
    await Future<void>.delayed(const Duration(seconds: 3));
    setState(() => visibleReloadCover = false);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    setState(() => visibleReloadCover = true);
  }

  @override
  Widget build(BuildContext context) {
    return ShopView(
      context: context,
      onRefresh: onRefresh,
      visibleReloadCover: visibleReloadCover,
      tickerProvider: this,
      productsLst: productsLst,
      productCount: productCount,
      moreProduct: moreProduct,
      categoriesLst: categoriesLst,
      categoriesId: categoriesId,
      getProducts: getProducts,
      filterSave: filterSave,
      onMoreBtn: onMoreBtn,
    );
  }
}
