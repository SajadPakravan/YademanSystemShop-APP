import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/tools/app_function.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/tools/app_themes.dart';

import '../../tools/app_dimension.dart';

// ignore: must_be_immutable
class ProductCardHorizontal extends StatelessWidget {
  ProductCardHorizontal({
    required this.listDetails,
    required this.listImage,
    this.physics = const AlwaysScrollableScrollPhysics(),
    super.key,
  });

  AppFunction appFun = AppFunction();
  AppTexts appTexts = AppTexts();
  AppDimension appDimension = AppDimension();
  double fontSize = 14;
  List<dynamic> listDetails;
  List<dynamic> listImage;
  ScrollPhysics physics;
  dynamic onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            ProductModel productModel = listDetails[index];
            Images productImage = listImage[index];
            String? name = productModel.name;
            int regularPrice = 0;
            int salePrice = 0;
            int percent = 0;
            String toman = " تومان";
            TextDecoration textDecoration = TextDecoration.none;
            Color textColor = Colors.black87;
            bool visibleSalePrice = false;

            // if (name!.isNotEmpty && name.length >= 40) {
            //   name = productModel.name!.replaceRange(40, productModel.name!.length, '...');
            // }

            if (productModel.regularPrice!.isNotEmpty) {
              regularPrice = int.parse(productModel.regularPrice!);
            }
            if (productModel.salePrice!.isNotEmpty) {
              salePrice = int.parse(productModel.salePrice!);
              visibleSalePrice = true;
              textDecoration = TextDecoration.lineThrough;
              textColor = Colors.black38;
              fontSize = 12;
              toman = "";
              percent = (((salePrice - regularPrice) / regularPrice) * 100).roundToDouble().toInt();
            }
            return InkWell(
              child: Container(
                width: width * 0.45,
                height: height,
                padding: EdgeInsets.all(width * 0.03),
                margin: EdgeInsets.all(width * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.02),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 3,
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: CachedNetworkImage(
                          imageUrl: productImage.src.toString(),
                          fit: BoxFit.contain,
                          errorWidget: (context, str, dyn) {
                            return const Icon(Icons.image, color: Colors.black26, size: 100);
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(vertical: width * 0.03),
                      child: AutoSizeText(
                        name.toString(),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxFontSize: appDimension.textNormal,
                        minFontSize: appDimension.textNormal,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: visibleSalePrice,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                            margin: EdgeInsets.only(left: width * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.circular(width * 0.01),
                            ),
                            child: AutoSizeText(
                              "${percent.toString().replaceAll('-', '').toPersianDigit()}%",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.buttonText1,
                              maxFontSize: appDimension.textNormal,
                              minFontSize: appDimension.textNormal,
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
                                  margin: EdgeInsets.only(bottom: width * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        salePrice.toString().toPersianDigit().seRagham(),
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context).textTheme.price,
                                        maxLines: 2,
                                        maxFontSize: appDimension.textNormal,
                                        minFontSize: appDimension.textNormal,
                                      ),
                                      AutoSizeText(
                                        "تومان",
                                        style: Theme.of(context).textTheme.price,
                                        maxFontSize: 10,
                                        minFontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AutoSizeText(
                                      regularPrice.toString().toPersianDigit().seRagham(),
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: textColor,
                                        fontFamily: appTexts.appFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        decoration: textDecoration,
                                      ),
                                      maxFontSize: fontSize,
                                      minFontSize: fontSize,
                                    ),
                                    AutoSizeText(
                                      toman,
                                      maxFontSize: 10,
                                      minFontSize: 10,
                                      style: Theme.of(context).textTheme.price,
                                    ),
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
                appFun.onTapProduct(id: productModel.id!);
              },
            );
          },
        ),
      ),
    );
  }
}
