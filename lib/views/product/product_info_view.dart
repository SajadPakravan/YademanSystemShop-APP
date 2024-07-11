import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';
import 'package:yad_sys/widgets/text_views/text_title_medium_view.dart';

class ProductInfoView extends StatelessWidget {
  const ProductInfoView({
    super.key,
    required this.context,
    required this.content,
    required this.description,
    required this.attributesLst,
  });

  final BuildContext context;
  final int content;
  final String description;
  final List<Attribute> attributesLst;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(appBar: appBar(), body: content == 1 ? productDescription() : attributes()),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black87),
      title: TextTitleMediumView(content == 1 ? 'معرفی محصول' : 'مشخصات محصول'),
    );
  }

  productDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: HtmlWidget(description)),
    );
  }

  attributes() {
    double width = MediaQuery.of(context).size.width;
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
              Expanded(child: Container(margin: EdgeInsets.only(left: width * 0.1), child: TextBodyMediumView(name))),
              Expanded(child: TextBodyMediumView(attribute.options![0])),
            ],
          ),
        );
      },
    );
  }
}
