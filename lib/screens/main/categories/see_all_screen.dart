import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/views/category_views/show_all_view.dart';

class ShowAllScreen extends StatefulWidget {
  const ShowAllScreen({super.key});

  @override
  State<ShowAllScreen> createState() => _ShowAllScreenState();
}

class _ShowAllScreenState extends State<ShowAllScreen> {
  HttpRequest httpRequest = HttpRequest();
  String category = Get.arguments[1];
  String onSale = Get.arguments[2];
  ScrollController scrollController = ScrollController();
  int page = 1;
  String order = "desc";
  String orderby = "date";
  bool moreProduct = false;
  List<ProductModel> productsDetLst = [];
  List<Images> productsImgLst = [];

  getProducts() async {
    dynamic jsonGetProducts = await httpRequest.getProducts(
      page: page,
      category: category,
      order: order,
      orderBy: orderby,
      onSale: onSale,
    );

    List jsonProductsImage = [];
    jsonGetProducts.forEach((i) {
      jsonProductsImage.add(i['images'][0]);
    });
    for (var image in jsonProductsImage) {
      setState(() {
        productsImgLst.add(Images(src: image['src']));
      });
    }
    jsonGetProducts.forEach((p) {
      setState(() {
        productsDetLst.add(
          ProductModel(
            id: p['id'],
            name: p['name'],
            regularPrice: p['regular_price'],
            price: p['sale_price'],
          ),
        );
      });
    });
    setState(() {
      moreProduct = false;
    });
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !moreProduct) {
      setState(() {
        moreProduct = true;
        page++;
      });
      getProducts();
    }
  }

  onRefresh() async {
    setState(() {
      productsDetLst.clear();
      productsImgLst.clear();
      page = 1;
    });
    getProducts();
    await Future<void>.delayed(const Duration(seconds: 5));
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return ShowAllView(
      context: context,
      onRefresh: onRefresh,
      scrollController: scrollController,
      productsDetLst: productsDetLst,
      productsImgLst: productsImgLst,
      moreProduct: moreProduct,
    );
  }
}
