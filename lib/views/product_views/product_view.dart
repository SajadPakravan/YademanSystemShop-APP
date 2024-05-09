import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/models/product_reviews_model.dart';
import 'package:yad_sys/tools/app_colors.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/view_models/product_view_model.dart';
import 'package:yad_sys/widgets/image_slides/product_slide.dart';

// ignore: must_be_immutable
class ProductView extends StatelessWidget {
  ProductView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.jsonProduct,
    required this.slideIndex,
    required this.onSlideChange,
    required this.name,
    required this.description,
    required this.attributes,
    required this.regularPrice,
    required this.salePrice,
    required this.productReviewsLst,
  });

  BuildContext context;
  dynamic onRefresh;
  AppTexts appTextStrings = AppTexts();
  AppDimension appDimension = AppDimension();
  AppColors appColors = AppColors();
  AppTexts appTexts = AppTexts();
  ProductViewModel productDetailViewModel = ProductViewModel();
  String name;
  String description;
  List attributes;
  int regularPrice;
  int salePrice;
  int quantity = 1;
  int pPrice = 0;
  double fontSize = 14;
  int categoryNumber = 1;
  IconData favoriteIcon = Icons.favorite;
  Color favoriteIconColor = Colors.red;
  bool favorite = false;
  List<ProductReviewsModel> productReviewsLst;
  dynamic jsonProduct;
  int slideIndex;
  Function onSlideChange;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            appBar(),
          ],
          body: RefreshIndicator(
            onRefresh: () {
              return onRefresh();
            },
            child: jsonProduct.isEmpty
                ? Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black54,
                      size: width * 0.1,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ProductSlide(
                          jsonProduct: jsonProduct,
                          slideIndex: slideIndex,
                          onSlideChange: onSlideChange,
                        ),
                        productDetails(),
                        productReviews(),
                        // relatedProducts(),
                      ],
                    ),
                  ),
          ),
        ),
        // bottomNavigationBar: cartPrice(),
      ),
    );
  }

  appBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
      elevation: 2,
      iconTheme: const IconThemeData(color: Colors.black54),
      title: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
            IconButton(
              icon: Icon(
                favoriteIcon,
                color: favoriteIconColor,
              ),
              onPressed: () {
                if (favorite) {
                  // setState(() {
                  //   favoriteIcon = Icons.favorite;
                  //   favoriteIconColor = Colors.red;
                  //   favorite = false;
                  // });
                } else {
                  // setState(() {
                  //   favoriteIcon = Icons.favorite_outline;
                  //   favoriteIconColor = Colors.black54;
                  //   favorite = true;
                  // });
                }
              },
            ),
            IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  productDetails() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(bottom: width * 0.04),
            child: AutoSizeText(
              name,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              minFontSize: appDimension.textNormal,
              maxFontSize: appDimension.textNormal,
            ),
          ),
          Visibility(
            visible: description.isEmpty ? false : true,
            child: productDetBtn(
              titleButton: appTextStrings.productDescription,
              content: 1,
            ),
          ),
          productDetBtn(
            titleButton: appTextStrings.productAttributes,
            content: 2,
          ),
        ],
      ),
    );
  }

  productDetBtn({
    required String titleButton,
    required int content,
  }) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.05),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleButton,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: width * 0.04,
            ),
          ],
        ),
      ),
      onTap: () {
        productDetailViewModel.onTapProductInfo(
          content: content,
          description: description,
          attributes: attributes,
        );
      },
    );
  }

  productReviews() {
    double width = MediaQuery.of(context).size.width;
    return productReviewsLst.isEmpty
        ? Container(
            margin: EdgeInsets.all(width * 0.04),
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.black54,
              size: width * 0.1,
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: width * 0.05),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "دیدگاه کاربران",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextButton.icon(
                          label: Text(
                            "مشاهده همه",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            // homeScrModel.onPressAllCatProducts(
                            //   categoryId: categoryId,
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 165,
                  child: ListView.builder(
                    itemCount: productReviewsLst.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      ProductReviewsModel productRev = productReviewsLst[index];

                      String? review = productRev.review;
                      String? reviewer = productRev.reviewer;
                      int? rating = productRev.rating;
                      Color rateColor = Colors.green;

                      switch (rating) {
                        case 1:
                          {
                            rateColor = Colors.red;
                            break;
                          }
                        case 2:
                          {
                            rateColor = Colors.red.shade300;
                            break;
                          }
                        case 3:
                          {
                            rateColor = Colors.green.shade300;
                            break;
                          }
                        case 4:
                          {
                            rateColor = Colors.green.shade400;
                            break;
                          }
                        case 5:
                          {
                            rateColor = Colors.green.shade600;
                            break;
                          }
                      }

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          InkWell(
                            child: Container(
                              width: 280,
                              height: 150,
                              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    padding: const EdgeInsets.all(5),
                                    child: HtmlWidget(
                                      review!,
                                      textStyle: Theme.of(context).textTheme.bodyMedium,
                                      customWidgetBuilder: (e) {
                                        return AutoSizeText(
                                          e.text,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          minFontSize: appDimension.textNormal,
                                          maxFontSize: appDimension.textNormal,
                                        );
                                      },
                                    ),
                                  ),
                                  Text(
                                    reviewer!,
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              // onTapProduct(productId: productModel.id!);
                            },
                          ),
                          Transform.translate(
                            offset: const Offset(0, -135),
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: rateColor,
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                "$rating.0".toPersianDigit(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
