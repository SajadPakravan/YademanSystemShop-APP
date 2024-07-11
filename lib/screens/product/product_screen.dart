import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/database/cart_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/tools/app_cache.dart';
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
  List<ProductModel> relatedProductsLst = [];
  bool loading = false;
  bool authError = false;
  int dataNumber = 0;
  IconData favoriteIcon = Icons.favorite;
  Color favoriteIconColor = Colors.red;
  bool favorite = false;
  bool isAddCart = false;
  int slideIndex = 0;
  Box<CartModel> cartBox = Hive.box<CartModel>('cartBox');

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
    ProductCategory category = product.categories![0];
    dynamic jsonRelatedProducts = await httpRequest.getProducts(perPage: 11, category: category.id.toString());
    jsonRelatedProducts.forEach((p) => setState(() => relatedProductsLst.add(ProductModel.fromJson(p))));
    setState(() => relatedProductsLst.removeWhere((element) => element.id == product.id));
    dataNumber++;
    loadContent();
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
      case 2:
        {
          getRelatedProducts();
          break;
        }
      default:
        {
          setState(() => loading = false);
          break;
        }
    }
  }

  addCart() async {
    AppCache cache = AppCache();
    String email = await cache.getString('email') ?? '';
    if (email.isEmpty) {
      setState(() => authError = true);
    } else {
      ProductImage img = product.images![0];
      setState(() {
        cartBox.add(CartModel(id: product.id!, name: product.name!, image: img.src!, price: int.parse(product.price!), quantity: 1));
      });
      print(cartBox.name);
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
      relatedProductsLst: relatedProductsLst,
      slideIndex: slideIndex,
      onSlideChange: onSlideChange,
      loading: loading,
      authError: authError,
      addCart: addCart,
    );
  }
}
