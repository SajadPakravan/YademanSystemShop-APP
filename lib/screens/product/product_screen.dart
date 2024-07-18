import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/database/cart_model.dart';
import 'package:yad_sys/database/favorite_model.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/views/product/product_view.dart';
import 'package:yad_sys/widgets/snack_bar_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  HttpRequest httpRequest = HttpRequest();
  ProductModel product = ProductModel();
  Box<CartModel> cartBox = Hive.box<CartModel>('cartBox');
  Box<FavoriteModel> favoritesBox = Hive.box<FavoriteModel>('favoritesBox');
  List<ReviewModel> reviewsLst = [];
  List<ProductModel> relatedProductsLst = [];
  bool existCart = false;
  bool loading = false;
  bool authError = false;
  int quantity = 0;
  int dataNumber = 0;
  IconData favoriteIcon = Icons.favorite_border;
  Color favoriteIconColor = Colors.black87;
  bool favorite = false;
  int slideIndex = 0;

  onSlideChange(index) => setState(() => slideIndex = index);

  getProduct(int id) async {
    dynamic jsonProduct = await httpRequest.getProduct(id: id);
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
    setState(() => relatedProductsLst.clear());
    ProductCategory category = product.categories![0];
    dynamic jsonRelatedProducts = await httpRequest.getProducts(perPage: 11, category: category.id.toString());
    jsonRelatedProducts.forEach((p) => setState(() => relatedProductsLst.add(ProductModel.fromJson(p))));
    setState(() => relatedProductsLst.removeWhere((element) => element.id == product.id));
    dataNumber++;
    loadContent();
  }

  loadContent({int? id}) {
    if (id != null) setState(() => dataNumber = 0);
    switch (dataNumber) {
      case 0:
        {
          setState(() => loading = true);
          getProduct(id!);
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
          checkCart();
          checkFavorites();
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
        cartBox.add(CartModel(
          id: product.id!,
          name: product.name!,
          image: img.src!,
          price: int.parse(product.price!),
          quantity: 1,
          shippingClass: product.shippingClass!,
        ));
      });
      checkCart();
    }
  }

  checkCart() {
    if (cartBox.isNotEmpty) {
      for (int i = 0; i < cartBox.length; i++) {
        CartModel cart = cartBox.getAt(i)!;
        if (cart.id == product.id) {
          setState(() {
            quantity = cart.quantity;
            existCart = true;
          });
        }
      }
    } else {
      setState(() => existCart = false);
    }
  }

  addRemoveFavorite() async {
    AppCache cache = AppCache();
    String email = await cache.getString('email') ?? '';
    if (email.isEmpty) {
      if (mounted) SnackBarView.show(context, 'لطفا وارد حساب کاربری خود شوید');
    } else if (favoriteIconColor == Colors.red) {
      final fav = favoritesBox.values.firstWhere((element) => element.id == product.id);
      fav.delete();
      setState(() {
        favoriteIcon = Icons.favorite_border;
        favoriteIconColor = Colors.black87;
      });
    } else {
      ProductImage img = product.images![0];
      setState(() {
        favoritesBox.add(FavoriteModel(
          id: product.id!,
          name: product.name!,
          image: img.src!,
          price: int.parse(product.price!),
          regularPrice: int.parse(product.regularPrice!),
          onSale: product.onSale!,
        ));
      });
      setState(() {
        favoriteIcon = Icons.favorite;
        favoriteIconColor = Colors.red;
      });
    }
  }

  checkFavorites() {
    if (favoritesBox.isNotEmpty) {
      for (int i = 0; i < favoritesBox.length; i++) {
        FavoriteModel favorite = favoritesBox.getAt(i)!;
        if (favorite.id == product.id) {
          setState(() {
            favoriteIcon = Icons.favorite;
            favoriteIconColor = Colors.red;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadContent(id: Get.arguments['id']);
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
      existCart: existCart,
      authError: authError,
      addCart: addCart,
      quantity: quantity,
      checkCart: checkCart,
      addRemoveFavorite: addRemoveFavorite,
      loadContent: loadContent,
      favoriteIcon: favoriteIcon,
      favoriteIconColor: favoriteIconColor,
    );
  }
}
