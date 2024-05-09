import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/views/product_views/product_info_view.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  String description = "";
  List attributes = [];
  List<Attributes> attributesNameLst = [];
  List<String> attributesOptionLst = [];
  int content = 0;
  String title = "";

  getDescription() async {
    if (kDebugMode) {
      print(">>>> description <<<<");
    }
    setState(() {
      description = Get.arguments["description"];
    });
  }

  getAttributes() async {
    if (kDebugMode) {
      print(">>>> attribute <<<<");
    }
    setState(() {
      attributes = Get.arguments["attributes"];
    });

    for (var att in attributes) {
      setState(() {
        attributesNameLst.add(Attributes(name: att['name']));
      });
    }

    List jsonProductAttributesOptions = [];

    for (var i = 0; i < attributes.length; i++) {
      setState(() {
        jsonProductAttributesOptions += attributes[i]['options'];
      });
    }

    for (var i = 0; i < jsonProductAttributesOptions.length; i++) {
      setState(() {
        attributesOptionLst.add(jsonProductAttributesOptions[i]);
      });
    }
  }

  loadContent() async {
    setState(() {
      content = Get.arguments["content"];
    });
    switch (content) {
      case 1:
        {
          setState(() {
            title = "معرفی محصول";
          });
          getDescription();
          break;
        }
      case 2:
        {
          setState(() {
            title = "مشخصات محصول";
          });
          getAttributes();
          break;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return ProductInfoView(
      context: context,
      title: title,
      content: content,
      description: description,
      attributesNameLst: attributesNameLst,
      attributesOptionLst: attributesOptionLst,
    );
  }
}
