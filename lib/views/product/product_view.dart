import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/screens/product/product_info_screen.dart';
import 'package:yad_sys/screens/profile/cart/cart_screen.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/tools/go_page.dart';
import 'package:yad_sys/widgets/cards/related_product_card.dart';
import 'package:yad_sys/widgets/image_slides/product_slide.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/snack_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_small_view.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.context,
    required this.product,
    required this.reviewsLst,
    required this.relatedProductsLst,
    required this.slideIndex,
    required this.onSlideChange,
    required this.loading,
    required this.existCart,
    required this.authError,
    required this.addCart,
    required this.quantity,
    required this.relatedProductOnTap,
    required this.checkCart,
    required this.addRemoveFavorite,
    required this.favoriteIcon,
    required this.favoriteIconColor,
  });

  final BuildContext context;
  final ProductModel product;
  final List<ReviewModel> reviewsLst;
  final List<ProductModel> relatedProductsLst;
  final int slideIndex;
  final Function onSlideChange;
  final bool loading;
  final bool existCart;
  final bool authError;
  final int quantity;
  final void Function() addCart;
  final Function() checkCart;
  final Function() addRemoveFavorite;
  final Function(ProductModel) relatedProductOnTap;
  final IconData favoriteIcon;
  final Color favoriteIconColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [appBar()],
            body: loading
                ? const Loading()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductSlide(product: product, slideIndex: slideIndex, onSlideChange: onSlideChange),
                        const SizedBox(height: 10),
                        productDetails(),
                        const SizedBox(height: 20),
                        relatedProducts(),
                      ],
                    ),
                  ),
          ),
          bottomNavigationBar: loading ? const Loading() : cartPrice()),
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
            IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () async {
                  AppCache cache = AppCache();
                  String email = await cache.getString('email') ?? '';
                  if (email.isEmpty) {
                    if (context.mounted) SnackBarView.show(context, 'لطفا وارد حساب کاربری خود شوید');
                  } else {
                    zoomToPage(const CartScreen());
                  }
                }),
            IconButton(icon: Icon(favoriteIcon, color: favoriteIconColor), onPressed: () => addRemoveFavorite()),
          ],
        ),
      ),
    );
  }

  productDetails() {
    ProductCategory category = product.categories![0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBodyMediumView(product.name!, maxLines: 2, fontWeight: FontWeight.bold),
          const SizedBox(height: 10),
          TextBodySmallView('دسته‌بندی: ${category.name!}', color: Colors.blue.shade900),
          const SizedBox(height: 20),
          Visibility(visible: product.description!.isEmpty ? false : true, child: infoBtn(title: 'معرفی محصول', content: 1)),
          infoBtn(title: 'مشخصات محصول', content: 2),
          Visibility(visible: reviewsLst.isEmpty ? false : true, child: infoBtn(title: 'دیدگاه‌ها', content: 3)),
        ],
      ),
    );
  }

  infoBtn({required String title, required int content}) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [TextBodyMediumView(title), const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 20)],
        ),
      ),
      onTap: () => rightToPage(
        const ProductInfoScreen(),
        arguments: {'content': content, 'description': product.description!, 'attributes': product.attributes!, 'reviews': reviewsLst},
      ),
    );
  }

  relatedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: TextBodyMediumView('محصولات مرتبط')),
        const SizedBox(height: 10),
        RelatedProductCard(list: relatedProductsLst, onTap: relatedProductOnTap),
      ],
    );
  }

  cartPrice() {
    int price = int.parse(product.price!);
    int regularPrice = int.parse(product.regularPrice!);
    int percent = 0;
    String toman = ' تومان';
    Color textColor = Colors.black87;
    double fontSize = 16;

    if (product.onSale!) {
      textColor = Colors.black54;
      fontSize = 14;
      toman = '';
      percent = (((price - regularPrice) / regularPrice) * 100).roundToDouble().toInt();
    }
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12, width: 3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            existCart
                ? IntrinsicWidth(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      title: Row(
                        children: [
                          TextBodyLargeView(quantity.toString().toPersianDigit(),
                              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
                          const SizedBox(width: 5),
                          const TextBodyMediumView('عدد در سبد خرید شما'),
                        ],
                      ),
                      subtitle: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: () async {
                          await Get.to(
                            const CartScreen(),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 300),
                            arguments: 5,
                          );
                          checkCart();
                        },
                        child: const TextBodyMediumView('رفتن به سبد خرید', color: Colors.white),
                      ),
                    ),
                  )
                : authError
                    ? const TextBodyMediumView('لطفا وارد حساب کاربری خود شوید', color: Colors.red)
                    : ElevatedButton(
                        style:
                            ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                        onPressed: addCart,
                        child: const TextBodyLargeView('افزودن به سبد خرید', color: Colors.white),
                      ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: product.onSale!,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextBodyLargeView(
                          price.toString().toPersianDigit().seRagham(),
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.bold,
                        ),
                        const TextBodyLargeView(' تومان', fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: product.onSale!,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(color: Colors.red.shade600),
                          child: TextBodyLargeView(
                            "${percent.toString().replaceAll('-', '').toPersianDigit()}%",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextBodyLargeView(
                        regularPrice.toString().toPersianDigit().seRagham(),
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                        color: textColor,
                      ),
                      TextBodyLargeView(toman, fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
