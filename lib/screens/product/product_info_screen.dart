import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/models/review_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/snack_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  HttpRequest httpRequest = HttpRequest();
  String title = '';
  Widget body = Container();
  List<Attribute> attributesLst = [];
  List<ReviewModel> reviewsLst = [];
  TextEditingController review = TextEditingController();
  bool logged = false;
  bool personalInfo = false;
  int rating = 0;
  int productId = 0;
  String name = '';
  String email = '';

  loadContent() async {
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
          await checkLogged();
          setState(() {
            title = 'دیدگاه‌ها';
            reviewsLst = Get.arguments['reviews'];
            body = reviews();
          });
          break;
        }
    }
  }

  checkLogged() async {
    AppCache cache = AppCache();
    email = await cache.getString('email') ?? '';
    name = await cache.getString('name') ?? '';
    setState(() {});
    logged = email.toString().isNotEmpty;
    personalInfo = name.toString().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(appBar: AppBarView(title: title), body: body));
  }

  description() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: HtmlWidget(
          Get.arguments['description'].toString().toPersianDigit(),
          textStyle: ThemeData.light().textTheme.bodyMedium!.copyWith(height: 2,fontSize: 16),
        ),
      ),
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
              Expanded(child: TextBodyMediumView(name, color: Colors.black54)),
              Expanded(child: TextBodyMediumView(attribute.options![0].toString().toPersianDigit())),
            ],
          ),
        );
      },
    );
  }

  reviews() {
    return SingleChildScrollView(
      child: Column(
        children: [
          !logged
              ? Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.red.shade200),
                  child: const TextBodyMediumView('برای ثبت نظر لطفا وارد حساب کاربری خود شوید'),
                )
              : !personalInfo
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.red.shade200),
                      child: const TextBodyMediumView('برای ثبت نظر لطفا بخش مشخصات فردی خود را تکمیل کنید'),
                    )
                  : Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: review,
                            style: ThemeData.light().textTheme.bodyMedium,
                            maxLines: 3,
                            minLines: 1,
                            decoration: InputDecoration(
                              hintText: 'دیدگاه خود را بنویسید',
                              hintStyle: ThemeData.light().textTheme.bodyMedium!.copyWith(color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const TextBodyMediumView('لطفا به محصول امتیاز دهید:'),
                          const SizedBox(height: 5),
                          RatingBar.builder(
                            initialRating: rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (double value) => setState(() => rating = value.toInt()),
                          ),
                          const SizedBox(height: 20),
                          EasyButton(
                            idleStateWidget: const TextBodyMediumView('ثبت دیدگاه', color: Colors.white),
                            loadingStateWidget: const Padding(padding: EdgeInsets.all(5), child: Loading(color: Colors.white)),
                            buttonColor: ColorStyle.blueFav,
                            onPressed: () async {
                              if (review.text.isEmpty || rating == 0) {
                                SnackBarView.show(context, 'لطفا دیدگاه و امتیاز خود را وارد کنید');
                              } else {
                                dynamic jsonReview = await httpRequest.createProductReview(
                                  context: context,
                                  id: productId,
                                  review: review.text,
                                  reviewer: name,
                                  email: email,
                                  rating: rating,
                                );
                                if (jsonReview != false) {
                                  if (mounted) SnackBarView.show(context, 'دیدگاه شما ثبت شد و بعد از تایید شدن منتشر می‌شود');
                                  setState(() {
                                    review.clear();
                                    rating = 0;
                                  });
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
          const SizedBox(height: 20),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviewsLst.length,
            itemBuilder: (BuildContext context, int index) {
              ReviewModel review = reviewsLst[index];
              ReviewerAvatarUrls avatar = review.avatarUrls!;
              productId = review.productId!;
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          CachedNetworkImage(imageUrl: avatar.s48!),
                          const SizedBox(width: 10),
                          Expanded(child: TextBodyMediumView(review.reviewer!))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HtmlWidget(
                            review.review!,
                            textStyle: ThemeData.light().textTheme.bodyMedium!.copyWith(color: Colors.black87, fontSize: 16),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.bottomLeft,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: RatingBar.builder(
                                initialRating: review.rating!.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (double value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
