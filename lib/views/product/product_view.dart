import 'package:flutter/material.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/view_models/product_view_model.dart';
import 'package:yad_sys/widgets/image_slides/product_slide.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class ProductView extends StatelessWidget {
  ProductView({
    super.key,
    required this.context,
    required this.product,
    required this.reviewsLst,
    required this.slideIndex,
    required this.onSlideChange,
    required this.loading,
  });

  final BuildContext context;
  final ProductModel product;
  final List<ReviewModel> reviewsLst;
  final int slideIndex;
  final Function onSlideChange;
  final ProductViewModel productDetailViewModel = ProductViewModel();
  final int quantity = 1;
  final int pPrice = 0;
  final double fontSize = 14;
  final int categoryNumber = 1;
  final IconData favoriteIcon = Icons.favorite;
  final Color favoriteIconColor = Colors.red;
  final bool favorite = false;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            appBar(),
          ],
          body: loading
              ? const Loading()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductSlide(product: product, slideIndex: slideIndex, onSlideChange: onSlideChange),
                      productDetails(),
                      // productReviews(),
                      // relatedProducts(),
                    ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(alignment: Alignment.centerRight, child: TextBodyMediumView(product.name!, maxLines: 2)),
          const SizedBox(height: 20),
          Visibility(visible: product.description!.isEmpty ? false : true, child: productDetBtn(title: 'معرفی محصول', content: 1)),
          productDetBtn(title: 'مشخصات محصول', content: 2),
        ],
      ),
    );
  }

  productDetBtn({required String title, required int content}) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [TextBodyMediumView(title), const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 20)],
        ),
      ),
      onTap: () => productDetailViewModel.onTapProductInfo(
        content: content,
        description: product.description!,
        attributes: product.attributes!,
      ),
    );
  }

  // cartPrice() {
  //   return
  // }

// productReviews() {
//   double width = MediaQuery.of(context).size.width;
//   return productReviewsLst.isEmpty
//       ? Container(
//           margin: EdgeInsets.all(width * 0.04),
//           child: LoadingAnimationWidget.threeArchedCircle(
//             color: Colors.black54,
//             size: width * 0.1,
//           ),
//         )
//       : Container(
//           padding: EdgeInsets.symmetric(vertical: width * 0.05),
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.black12,
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.03),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "دیدگاه کاربران",
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     Directionality(
//                       textDirection: TextDirection.ltr,
//                       child: TextButton.icon(
//                         label: Text(
//                           "مشاهده همه",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.black87,
//                         ),
//                         onPressed: () {
//                           // homeScrModel.onPressAllCatProducts(
//                           //   categoryId: categoryId,
//                           // );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 165,
//                 child: ListView.builder(
//                   itemCount: productReviewsLst.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (BuildContext context, int index) {
//                     ReviewModel productRev = productReviewsLst[index];
//
//                     String? review = productRev.review;
//                     String? reviewer = productRev.reviewer;
//                     int? rating = productRev.rating;
//                     Color rateColor = Colors.green;
//
//                     switch (rating) {
//                       case 1:
//                         {
//                           rateColor = Colors.red;
//                           break;
//                         }
//                       case 2:
//                         {
//                           rateColor = Colors.red.shade300;
//                           break;
//                         }
//                       case 3:
//                         {
//                           rateColor = Colors.green.shade300;
//                           break;
//                         }
//                       case 4:
//                         {
//                           rateColor = Colors.green.shade400;
//                           break;
//                         }
//                       case 5:
//                         {
//                           rateColor = Colors.green.shade600;
//                           break;
//                         }
//                     }
//
//                     return Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         InkWell(
//                           child: Container(
//                             width: 280,
//                             height: 150,
//                             margin: EdgeInsets.symmetric(horizontal: width * 0.02),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.grey,
//                                 width: 1,
//                               ),
//                               borderRadius: const BorderRadius.all(Radius.circular(5)),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(top: 15),
//                                   padding: const EdgeInsets.all(5),
//                                   child: HtmlWidget(
//                                     review!,
//                                     textStyle: Theme.of(context).textTheme.bodyMedium,
//                                     customWidgetBuilder: (e) {
//                                       return AutoSizeText(
//                                         e.text,
//                                         textAlign: TextAlign.right,
//                                         style: Theme.of(context).textTheme.bodyMedium,
//                                         maxLines: 4,
//                                         overflow: TextOverflow.ellipsis,
//                                         minFontSize: appDimension.textNormal,
//                                         maxFontSize: appDimension.textNormal,
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Text(
//                                   reviewer!,
//                                   textAlign: TextAlign.right,
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             // onTapProduct(productId: productModel.id!);
//                           },
//                         ),
//                         Transform.translate(
//                           offset: const Offset(0, -135),
//                           child: Container(
//                             width: 30,
//                             height: 30,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: rateColor,
//                               borderRadius: const BorderRadius.all(Radius.circular(5)),
//                             ),
//                             child: Text(
//                               "$rating.0".toPersianDigit(),
//                               style: Theme.of(context).textTheme.bodyMedium,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
// }
}
