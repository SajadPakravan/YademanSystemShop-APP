import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/tools/app_function.dart';
import 'package:yad_sys/views/main_views/home_view.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HttpRequest httpRequest = HttpRequest(context: Get.context!);
  AppFunction appFun = AppFunction();

  // List<Images> offImgLstUpdate = [];
  // List<ProductModel> offDetLstUpdate = [];
  // List<ProductCategoryImage> categoriesImgLstUpdate = [];
  // List<ProductCategoryModel> categoriesLstUpdate = [];
  // List<Images> laptopImgLstUpdate = [];
  // List<ProductModel> laptopDetLstUpdate = [];
  // List<Images> speakerImgLstUpdate = [];
  // List<ProductModel> speakerDetLstUpdate = [];
  // List<Images> internalImgLstUpdate = [];
  // List<ProductModel> internalDetLstUpdate = [];
  // List<Images> storageImgLstUpdate = [];
  // List<ProductModel> storageDetLstUpdate = [];

  List<Images> offImgLst = [];
  List<ProductModel> offDetLst = [];
  List<ProductCategoryImage> categoriesImgLst = [];
  List<ProductCategoryModel> categoriesLst = [];
  List<Images> laptopImgLst = [];
  List<ProductModel> laptopDetLst = [];
  List<Images> speakerImgLst = [];
  List<ProductModel> speakerDetLst = [];
  List<Images> internalImgLst = [];
  List<ProductModel> internalDetLst = [];
  List<Images> storageImgLst = [];
  List<ProductModel> storageDetLst = [];

  bool visibleReloadCover = true;
  int categoryNumber = 1;
  int updateCount = 1;
  bool showContent = false;
  int slideIndex = 0;

  onSlideChange(index) {
    setState(() {
      slideIndex = index;
    });
  }

  getProducts({
    String categoryId = "",
    String onSale = "",
    int perPage = 10,
    required List listProductImage,
    required List listProductDetail,
  }) async {
    dynamic jsonGetCategoryProducts = await httpRequest.getProducts(
      category: categoryId,
      onSale: onSale,
      perPage: perPage,
    );
    List jsonProductsImage = [];
    List<Images> pImage = [];
    jsonGetCategoryProducts.forEach((i) {
      jsonProductsImage.add(i['images'][0]);
    });
    for (var image in jsonProductsImage) {
      setState(() {
        pImage.add(Images(src: image['src']));
      });
    }
    listProductImage.addAll(pImage);

    List<ProductModel> pDetails = [];
    jsonGetCategoryProducts.forEach((p) {
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
    listProductDetail.addAll(pDetails);
    categoryNumber++;
    loadCategory();
  }

  getParentCategories() async {
    dynamic jsonGetCategories = await httpRequest.getCategories(
      perPage: 9,
      include: "57,1818,1809,54,153,158,67,1601,1773,51,1816,151",
    );

    List jsonCategoriesImage = [];
    List<ProductCategoryImage> cImage = [];

    jsonGetCategories.forEach((i) {
      setState(() {
        jsonCategoriesImage.add(i['image']['src']);
      });
    });

    for (var image in jsonCategoriesImage) {
      setState(() {
        cImage.add(ProductCategoryImage(src: image));
      });
    }

    categoriesImgLst = cImage;

    List<ProductCategoryModel> c = [];
    jsonGetCategories.forEach((pc) {
      setState(() {
        c.add(
          ProductCategoryModel(
            id: pc['id'],
            name: pc['name'],
          ),
        );
      });
    });
    categoriesLst = c;
    categoryNumber++;
    loadCategory();
  }

  loadCategory() {
    switch (categoryNumber) {
      case 1:
        {
          getProducts(
            onSale: "true",
            listProductImage: offImgLst,
            listProductDetail: offDetLst,
          ); // پیشنهاد شگفت انگیز
          break;
        }
      case 2:
        {
          getParentCategories(); // خرید بر اساس دسته بندی
          break;
        }
      case 3:
        {
          getProducts(
            categoryId: "57",
            perPage: 9,
            listProductImage: laptopImgLst,
            listProductDetail: laptopDetLst,
          ); // لپ تاپ
          break;
        }
      case 4:
        {
          getProducts(
            categoryId: "153",
            perPage: 9,
            listProductImage: speakerImgLst,
            listProductDetail: speakerDetLst,
          ); // اسپیکر
          break;
        }
      default:
        {
          setState(() {
            showContent = true;
            // offImgLst = offImgLst;
            // offDetLst = offDetLst;
            // categoriesImgLst = categoriesImgLst;
            // categoriesLst = categoriesLst;
            // laptopImgLst = laptopImgLst;
            // laptopDetLst = laptopDetLst;
            // speakerImgLst = speakerImgLst;
            // speakerDetLst = speakerDetLst;
          });
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  onRefresh() async {
    setState(() {
      categoryNumber = 1;
    });
    loadCategory();
    await Future<void>.delayed(const Duration(seconds: 10));
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
    return HomeView(
      context: context,
      onRefresh: onRefresh,
      visibleReloadCover: visibleReloadCover,
      showContent: showContent,
      slideIndex: slideIndex,
      onSlideChange: onSlideChange,
      offDetLst: offDetLst,
      offImgLst: offImgLst,
      categoriesLst: categoriesLst,
      categoriesImgLst: categoriesImgLst,
      laptopDetLst: laptopDetLst,
      laptopImgLst: laptopImgLst,
      speakerDetLst: speakerDetLst,
      speakerImgLst: speakerImgLst,
      internalDetLst: internalDetLst,
      internalImgLst: internalImgLst,
      storageDetLst: storageDetLst,
      storageImgLst: storageImgLst,
    );
  }
}
