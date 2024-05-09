import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/widgets/app_dialogs.dart';
import 'package:yad_sys/widgets/cards/product_card_grid.dart';

// ignore: must_be_immutable
class ShowAllView extends StatelessWidget {
  ShowAllView({
    super.key,
    required this.context,
    required this.onRefresh,
    required this.scrollController,
    required this.productsDetLst,
    required this.productsImgLst,
    required this.moreProduct,
  });

  BuildContext context;
  dynamic onRefresh;
  AppDialogs appDialogs = AppDialogs();
  ScrollController scrollController;
  List<ProductModel> productsDetLst;
  List<Images> productsImgLst;
  bool moreProduct;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            appBar(),
          ],
          body: RefreshIndicator(
            onRefresh: () {
              return onRefresh();
            },
            child: productsDetLst.isEmpty
                ? Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black54,
                      size: width * 0.1,
                    ),
                  )
                : SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ProductCardGrid(
                          listDetails: productsDetLst,
                          listImage: productsImgLst,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        moreProduct
                            ? LoadingAnimationWidget.threeArchedCircle(
                                color: Colors.black54,
                                size: width * 0.1,
                              )
                            : const Icon(Icons.more_horiz_rounded),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  appBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
      forceElevated: true,
      title: AutoSizeText(Get.arguments[0], maxLines: 1, style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black54),
    );
  }
}
