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
  int productCount = 0;
  bool loading = false;

  setFilters() async {
    setState(() {
      filtersLst.add({'index': 0, 'name': 'جدیدترین', 'order': 'desc', 'orderby': 'date', 'onSale': 'false', 'select': true});
      filtersLst.add({'index': 1, 'name': 'قدیمی‌ترین', 'order': 'asc', 'orderby': 'date', 'onSale': 'false', 'select': false});
      filtersLst.add({'index': 2, 'name': 'تخفیف خورده', 'order': 'desc', 'orderby': 'date', 'onSale': 'true', 'select': false});
      filtersLst.add({'index': 3, 'name': 'گران‌ترین', 'order': 'desc', 'orderby': 'price', 'onSale': 'false', 'select': false});
      filtersLst.add({'index': 4, 'name': 'ارزان ترین', 'order': 'asc', 'orderby': 'price', 'onSale': 'false', 'select': false});
      filtersLst.add({'index': 5, 'name': 'محبوب‌ترین', 'order': 'desc', 'orderby': 'popularity', 'onSale': 'false', 'select': false});
      filtersLst.add({'index': 6, 'name': 'بالاترین امتیاز', 'order': 'desc', 'orderby': 'rating', 'onSale': 'false', 'select': false});
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

    for (var filter in filtersLst) {
      if (filter['select']) setState(() => filterSelected = filter['index']);
    }
    print(filtersLst[filterSelected]['name']);

    dynamic jsonProducts = await httpRequest.getProducts(
      page: page,
      category: categoriesId.isEmpty ? '' : categoriesId.toString().replaceAll(RegExp(r'[^0-9,]'), ''),
      order: filtersLst[filterSelected]['order'],
      orderBy: filtersLst[filterSelected]['orderby'],
      onSale: filtersLst[filterSelected]['onSale'],
    );
    setState(() => productCount = 0);
    jsonProducts.forEach((p) {
      productsLst.add(ProductModel.fromJson(p));
      setState(() => productCount++);
    });
    setState(() => moreProduct = false);
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
