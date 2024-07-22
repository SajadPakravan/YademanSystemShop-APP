import 'package:get/get.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/screens/product/product_screen.dart';

rightToPage(dynamic page, {dynamic arguments}) {
  return Get.to(page, transition: Transition.rightToLeft, duration: const Duration(milliseconds: 300), arguments: arguments);
}

zoomToPage(dynamic page, {dynamic arguments}) {
  return Get.to(page, transition: Transition.zoom, duration: const Duration(milliseconds: 300), arguments: arguments);
}

toProduct(ProductModel product) => zoomToPage(const ProductScreen(), arguments: product);
