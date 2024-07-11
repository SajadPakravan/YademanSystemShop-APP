import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/views/product/product_info_view.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  String description = '';
  List<Attribute> attributesLst = [];

  @override
  Widget build(BuildContext context) {
    return ProductInfoView(
      context: context,
      content: Get.arguments['content'],
      description: Get.arguments['description'],
      attributesLst: Get.arguments['attributes'],
    );
  }
}
