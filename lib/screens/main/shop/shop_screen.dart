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

class ShopScreenState extends State<ShopScreen> {
  HttpRequest httpRequest = HttpRequest();
  List<ProductModel> productsLst = [];
  List<ProductCategoryModel> categoriesLst = [];
  List<int> categoriesId = [];
  List<Map<String, dynamic>> filtersLst = [];
  int filterSelected = 1;
  bool visibleReloadCover = true;
  int page = 1;
  bool moreProduct = false;
  Map<String, List<String>> categoriesSave = {};
  String order = 'desc';
  String orderBy = 'date';
  String onSale = '';
  List<Map<String, dynamic>> filterSave = [];
  int productCount = 0;

  setFilters() async {
    setState(() {
      filtersLst.add({'id': 1, 'name': 'جدیدترین', 'order': 'desc', 'orderby': 'date', 'select': true});
      filtersLst.add({'id': 2, 'name': 'قدیمی‌ترین', 'order': 'asc', 'orderby': 'date', 'select': false});
      filtersLst.add({'id': 3, 'name': 'تخفیف خورده', 'order': 'desc', 'orderby': 'date', 'onSale': true, 'select': false});
      filtersLst.add({'id': 4, 'name': 'گران‌ترین', 'order': 'desc', 'orderby': 'price', 'select': false});
      filtersLst.add({'id': 5, 'name': 'ارزان ترین', 'order': 'asc', 'orderby': 'price', 'select': false});
      filtersLst.add({'id': 6, 'name': 'محبوب‌ترین', 'order': 'desc', 'orderby': 'popularity', 'select': false});
      filtersLst.add({'id': 7, 'name': 'بالاترین امتیاز', 'order': 'desc', 'orderby': 'rating', 'select': false});
    });
    dynamic jsonCategories = await httpRequest.getCategories(perPage: 100);
    jsonCategories.forEach((category) {
      setState(() => categoriesLst.add(ProductCategoryModel.fromJson(category)));
    });
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
    setFilters();
    getProducts();
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
      productsLst: productsLst,
      productCount: productCount,
      moreProduct: moreProduct,
      categoriesLst: categoriesLst,
      categoriesId: categoriesId,
      getProducts: getProducts,
      filtersLst: filtersLst,
      filterSelected: filterSelected,
      onMoreBtn: onMoreBtn,
    );
  }
}
