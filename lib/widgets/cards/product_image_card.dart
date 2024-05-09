import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/tools/app_function.dart';

// ignore: must_be_immutable
class ProductImageCard extends StatelessWidget {
  ProductImageCard({
    required this.listImage,
    required this.listDet,
    this.physics = const AlwaysScrollableScrollPhysics(),
    super.key,
  });

  AppFunction appFun = AppFunction();
  List<dynamic> listImage;
  List<dynamic> listDet;
  ScrollPhysics physics;
  BorderSide borderSideTop = BorderSide.none;
  BorderSide borderSideBottom = BorderSide.none;
  BorderSide borderSideLeft = BorderSide.none;
  BorderSide borderSideRight = BorderSide.none;
  Color color1 = Colors.white;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        scrollDirection: Axis.vertical,
        physics: physics,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          ProductModel productModel = listDet[index];
          Images productImage = listImage[index];
          switch (index) {
            case 0:
            case 2:
            case 3:
            case 5:
              {
                border(borderSideBottom: const BorderSide(color: Colors.black26));
                break;
              }
            case 1:
            case 4:
              {
                border(
                  borderSideBottom: const BorderSide(color: Colors.black26),
                  borderSideLeft: const BorderSide(color: Colors.black26),
                  borderSideRight: const BorderSide(color: Colors.black26),
                );
                break;
              }
            case 7:
              {
                border(
                  borderSideLeft: const BorderSide(color: Colors.black26),
                  borderSideRight: const BorderSide(color: Colors.black26),
                );
                break;
              }
            case 6:
            case 8:
              {
                border();
                break;
              }
          }
          return InkWell(
            child: Container(
              padding: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                border: Border(
                  top: borderSideTop,
                  bottom: borderSideBottom,
                  left: borderSideLeft,
                  right: borderSideRight,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: productImage.src.toString(),
                fit: BoxFit.contain,
                errorWidget: (context, str, dyn) {
                  return const Icon(Icons.image, color: Colors.black26, size: 100);
                },
              ),
            ),
            onTap: () {
              appFun.onTapProduct(id: productModel.id!);
            },
          );
        },
      ),
    );
  }

  border({
    BorderSide borderSideTop = BorderSide.none,
    BorderSide borderSideBottom = BorderSide.none,
    BorderSide borderSideLeft = BorderSide.none,
    BorderSide borderSideRight = BorderSide.none,
  }) {
    this.borderSideTop = borderSideTop;
    this.borderSideBottom = borderSideBottom;
    this.borderSideLeft = borderSideLeft;
    this.borderSideRight = borderSideRight;
  }
}
