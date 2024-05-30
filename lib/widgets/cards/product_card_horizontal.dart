import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/tools/app_function.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/themes/app_themes.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';
import 'package:yad_sys/widgets/text_views/text_title_medium_view.dart';

class ProductCardHorizontal extends StatelessWidget {
  ProductCardHorizontal({
    super.key,
    required this.listDetails,
    required this.listImage,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.onTap,
  });

  final AppFunction appFun = AppFunction();
  final AppTexts appTexts = AppTexts();
  final AppDimension appDimension = AppDimension();
  final List<dynamic> listDetails;
  final List<dynamic> listImage;
  final ScrollPhysics physics;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fontSize = 14;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: listImage.length,
          scrollDirection: Axis.horizontal,
          physics: physics,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, int index) {
            ProductModel product = listDetails[index];
            Images productImage = listImage[index];

            int regularPrice = 0;
            int salePrice = 0;
            int percent = 0;
            String toman = 'تومان';
            TextDecoration textDecoration = TextDecoration.none;
            Color textColor = Colors.black87;
            bool visibleSalePrice = false;

            if (product.regularPrice!.isNotEmpty) {
              regularPrice = int.parse(product.regularPrice!);
            }
            if (product.salePrice!.isNotEmpty) {
              salePrice = int.parse(product.salePrice!);
              visibleSalePrice = true;
              textDecoration = TextDecoration.lineThrough;
              textColor = Colors.black45;
              fontSize = 12;
              toman = '';
              percent = (((salePrice - regularPrice) / regularPrice) * 100).roundToDouble().toInt();
            }
            return InkWell(
              child: Container(
                width: width * 0.45,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 3)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CachedNetworkImage(
                          imageUrl: productImage.src!,
                          fit: BoxFit.contain,
                          errorWidget: (context, str, dyn) => const Icon(Icons.image, color: Colors.black26, size: 100),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TextBodyMediumView(product.name!, maxLines: 2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: visibleSalePrice,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.red.shade600),
                            child: TextBodyMediumView(
                              "${percent.toString().replaceAll('-', '').toPersianDigit()}%",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Visibility(
                                visible: visibleSalePrice,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextBodyMediumView(
                                        salePrice.toString().toPersianDigit().seRagham(),
                                        textAlign: TextAlign.left,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const TextBodyMediumView("تومان", fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextBodyMediumView(
                                      regularPrice.toString().toPersianDigit().seRagham(),
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: textColor,
                                    ),
                                    TextBodyMediumView(toman, fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                appFun.onTapProduct(id: product.id!);
              },
            );
          },
        ),
      ),
    );
  }
}
