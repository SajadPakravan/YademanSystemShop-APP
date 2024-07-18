import 'package:get/get.dart';
import 'package:yad_sys/screens/categories/see_all_screen.dart';
import 'package:yad_sys/screens/product/product_screen.dart';

class AppFunction {
  onTapProduct({required int id}) async =>
      Get.to(const ProductScreen(), transition: Transition.zoom, duration: const Duration(milliseconds: 300), arguments: {'id': id});

  onTapShowAll({required String title, String category = '', String onSale = ''}) async => Get.to(const ShowAllScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
      arguments: {'title': title, 'category': category, 'onSale': onSale});
}
