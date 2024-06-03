import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/product_reviews_model.dart';
import 'package:yad_sys/views/product_views/product_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  HttpRequest httpRequest = HttpRequest();
  dynamic jsonProduct = "";
  dynamic jsonGetProductReviews = "";
  List<ProductModel> productsDetLst = [];
  List<Images> productsImg = [];
  List<ProductReviewsModel> productReviewsLst = [];
  int categoryId = 0;
  String name = "";
  String description = "";
  List attributes = [];
  int regularPrice = 0;
  int salePrice = 0;
  int numLoad = 0;
  IconData favoriteIcon = Icons.favorite;
  Color favoriteIconColor = Colors.red;
  bool favorite = false;
  bool isAddCart = false;
  int slideIndex = 0;

  onSlideChange(index) {
    setState(() {
      slideIndex = index;
    });
  }

  getProduct() async {
    jsonProduct = await httpRequest.getProduct();
    setState(() {
      categoryId = jsonProduct["categories"][0]["id"];
      name = jsonProduct['name'];
      description = jsonProduct['description'];
      attributes = jsonProduct['attributes'];
    });

    if (regularPrice != 0) {
      regularPrice = int.parse(jsonProduct['regular_price'].toString().toPersianDigit().seRagham());
    }
    if (salePrice != 0) {
      salePrice = int.parse(jsonProduct['sale_price'].toString().toPersianDigit());
    }
    numLoad++;
    loadContent();
  }

  getProductReviews() async {
    jsonGetProductReviews = await httpRequest.getProductReviews();

    for (var r in jsonGetProductReviews) {
      setState(() {
        productReviewsLst.add(
          ProductReviewsModel(
            id: r['id'],
            reviewer: r['reviewer'],
            review: r['review'],
            rating: r['rating'],
            dateCreated: r['date_created'],
          ),
        );
      });
    }
    numLoad++;
    loadContent();
  }

  getRelatedProducts() async {
    dynamic jsonGetRelatedProducts = await httpRequest.getProducts(
      category: categoryId.toString(),
      perPage: 10,
    );

    List json = jsonGetRelatedProducts;

    SharedPreferences sharePref = await SharedPreferences.getInstance();
    int? productId = sharePref.getInt("productId");

    json.removeWhere((e) => e["id"] == productId);

    List jsonProductsImages = [];

    for (var i in json) {
      jsonProductsImages.add(i['images'][0]);
    }
    for (var image in jsonProductsImages) {
      setState(() {
        productsImg.add(Images(src: image['src']));
      });
    }

    for (var p in json) {
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
    }
    numLoad++;
    loadContent();
  }

  loadContent() {
    switch (numLoad) {
      case 0:
        {
          getProduct();
          break;
        }
      case 1:
        {
          getProductReviews();
          break;
        }
      case 2:
        {
          // getRelatedProducts();
          break;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  Future<void> onRefresh() async {
    setState(() {
      jsonProduct.clear();
      productsDetLst.clear();
      productsImg.clear();
      productReviewsLst.clear();
      numLoad = 0;
      slideIndex = 0;
    });
    loadContent();
    await Future<void>.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return ProductView(
      context: context,
      onRefresh: onRefresh,
      jsonProduct: jsonProduct,
      slideIndex: slideIndex,
      onSlideChange: onSlideChange,
      name: name,
      description: description,
      attributes: attributes,
      regularPrice: regularPrice,
      salePrice: salePrice,
      productReviewsLst: productReviewsLst,
    );
  }
}
