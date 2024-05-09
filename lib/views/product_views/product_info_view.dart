import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/tools/app_colors.dart';

// ignore: must_be_immutable
class ProductInfoView extends StatelessWidget {
  ProductInfoView({
    required this.context,
    required this.title,
    required this.content,
    required this.description,
    required this.attributesNameLst,
    required this.attributesOptionLst,
    super.key,
  });

  BuildContext context;
  String title;
  int content;
  String description;
  List<Attributes> attributesNameLst;
  List<String> attributesOptionLst;
  AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(),
        body: content == 1
                ? productDescription()
                : attributes(),
      ),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black87,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  productDescription() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: HtmlWidget(
          description,
        ),
      ),
    );
  }

  attributes() {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: attributesNameLst.length,
      itemBuilder: (BuildContext context, int index) {
        Attributes productAttributes = attributesNameLst[index];
        String name = productAttributes.name!;
        name = name.replaceAll("-", " ");

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: width * 0.05,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black26, width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: width * 0.1),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  attributesOptionLst[index].toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
