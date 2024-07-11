import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/views/product/product_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  HttpRequest httpRequest = HttpRequest();
  ProductModel product = ProductModel();
  List<ReviewModel> reviewsLst = [];
  int dataNumber = 0;
  IconData favoriteIcon = Icons.favorite;
  Color favoriteIconColor = Colors.red;
  bool favorite = false;
  bool isAddCart = false;
  int slideIndex = 0;
  bool loading = false;

  onSlideChange(index) => setState(() => slideIndex = index);

  getProduct() async {
    dynamic jsonProduct = await httpRequest.getProduct();
    setState(() => product = ProductModel.fromJson(jsonProduct));
    dataNumber++;
    loadContent();
  }

  getProductReviews() async {
    dynamic jsonReviews = await httpRequest.getProductReviews();
    jsonReviews.forEach((r) => setState(() => reviewsLst.add(ReviewModel.fromJson(r))));
    dataNumber++;
    loadContent();
  }

  getRelatedProducts() async {
    // dynamic jsonGetRelatedProducts = await httpRequest.getProducts(
    //   category: product.categories.toString(),
    //   perPage: 10,
    // );

    // List json = jsonGetRelatedProducts;
    //
    // SharedPreferences sharePref = await SharedPreferences.getInstance();
    // int? productId = sharePref.getInt("productId");
    //
    // json.removeWhere((e) => e["id"] == productId);
    //
    // List jsonProductsImages = [];
    //
    // for (var i in json) {
    //   jsonProductsImages.add(i['images'][0]);
    // }
    // for (var image in jsonProductsImages) {
    //   setState(() {
    //     productsImg.add(Images(src: image['src']));
    //   });
    // }
    //
    // for (var p in json) {
    //   setState(() {
    //     productsDetLst.add(
    //       ProductModel(
    //         id: p['id'],
    //         name: p['name'],
    //         regularPrice: p['regular_price'],
    //         price: p['sale_price'],
    //       ),
    //     );
    //   });
    // }
    // dataNumber++;
    // loadContent();
  }

  loadContent() {
    switch (dataNumber) {
      case 0:
        {
          setState(() => loading = true);
          getProduct();
          break;
        }
      case 1:
        {
          getProductReviews();
          break;
        }
      // case 2:
      //   {
      //     // getRelatedProducts();
      //     break;
      //   }
      default:
        {
          setState(() => loading = false);
          break;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return ProductView(
      context: context,
      product: product,
      reviewsLst: reviewsLst,
      slideIndex: slideIndex,
      onSlideChange: onSlideChange,
      loading: loading,
    );
  }
}
