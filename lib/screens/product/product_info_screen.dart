import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  String title = '';
  late Widget body;
  List<Attribute> attributesLst = [];
  List<ReviewModel> reviewsLst = [];

  @override
  void initState() {
    super.initState();
    switch (Get.arguments['content']) {
      case 1:
        {
          setState(() {
            title = 'معرفی محصول';
            body = description();
          });
          break;
        }
      case 2:
        {
          setState(() {
            title = 'مشخصات محصول';
            attributesLst = Get.arguments['attributes'];
            body = attributes();
          });
          break;
        }
      case 3:
        {
          setState(() {
            title = 'دیدگاه‌ها';
            reviewsLst = Get.arguments['reviews'];
            body = reviews();
          });
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(appBar: AppBarView(title: title), body: body));
  }

  description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: HtmlWidget(Get.arguments['description'])),
    );
  }

  attributes() {
    return ListView.builder(
      itemCount: attributesLst.length,
      itemBuilder: (BuildContext context, int index) {
        Attribute attribute = attributesLst[index];
        String name = attribute.name!.replaceAll('-', ' ');
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
          child: Row(
            children: [
              Expanded(child: TextBodyMediumView(name)),
              const SizedBox(width: 10),
              Expanded(child: TextBodyMediumView(attribute.options![0])),
            ],
          ),
        );
      },
    );
  }

  reviews() {
    return ListView.builder(
      itemCount: reviewsLst.length,
      itemBuilder: (BuildContext context, int index) {
        ReviewModel review = reviewsLst[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
          child: Row(
            children: [
              Expanded(child: TextBodyMediumView(review.reviewer!)),
              Expanded(child: TextBodyMediumView(review.review!)),
            ],
          ),
        );
      },
    );
  }
}
