import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/views/main_views/categories_view.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  HttpRequest httpRequest = HttpRequest();
  List<ProductCategoryModel> parentCategoriesLst = [];
  List<ProductCategoryImage> parentCategoriesImgLst = [];
  List<ProductCategoryModel> speakerSubCategoriesLst = [];
  List<ProductCategoryImage> speakerSubCategoriesImgLst = [];
  List<ProductCategoryModel> computerAccessoriesSubCategoriesLst = [];
  List<ProductCategoryImage> computerAccessoriesSubCategoriesImgLst = [];
  List<ProductCategoryModel> hardwareComputerSubCategoriesLst = [];
  List<ProductCategoryImage> hardwareComputerSubCategoriesImgLst = [];
  List<ProductCategoryModel> laptopAccessoriesSubCategoriesLst = [];
  List<ProductCategoryImage> laptopAccessoriesSubCategoriesImgLst = [];
  List<ProductCategoryModel> headphoneHandsfreeSubCategoriesLst = [];
  List<ProductCategoryImage> headphoneHandsfreeSubCategoriesImgLst = [];
  List<ProductCategoryModel> storageEquipmentSubCategoriesLst = [];
  List<ProductCategoryImage> storageEquipmentSubCategoriesImgLst = [];
  List<ProductCategoryModel> networkEquipmentSubCategoriesLst = [];
  List<ProductCategoryImage> networkEquipmentSubCategoriesImgLst = [];
  int categoryNumber = 1;
  bool showContent = false;

  getParentCategories() async {
    dynamic jsonGetCategories = await httpRequest.getCategories(
      perPage: 100,
      include: "57,1818,1809,54,153,158,67,1601,1773,51,1816,151",
    );

    List jsonCategoriesImage = [];

    jsonGetCategories.forEach((i) {
      setState(() {
        jsonCategoriesImage.add(i['image']['src']);
      });
    });

    for (var image in jsonCategoriesImage) {
      setState(() {
        parentCategoriesImgLst.add(ProductCategoryImage(src: image));
      });
    }

    jsonGetCategories.forEach((pc) {
      setState(() {
        parentCategoriesLst.add(
          ProductCategoryModel(
            id: pc['id'],
            name: pc['name'],
          ),
        );
      });
    });
    loadSubCategories();
  }

  getSubCategories({
    required int parent,
    required List subCategoriesLst,
    required List subCategoriesImgLst,
  }) async {
    dynamic jsonGetCategories = await httpRequest.getCategories(
      parent: parent,
      perPage: 100,
    );

    List jsonCategoriesImage = [];

    jsonGetCategories.forEach((i) {
      setState(() {
        jsonCategoriesImage.add(i['image']['src']);
      });
    });

    for (var image in jsonCategoriesImage) {
      setState(() {
        subCategoriesImgLst.add(ProductCategoryImage(src: image));
      });
    }

    jsonGetCategories.forEach((pc) {
      setState(() {
        subCategoriesLst.add(
          ProductCategoryModel(
            id: pc['id'],
            name: pc['name'],
          ),
        );
      });
    });
    categoryNumber++;
    loadSubCategories();
  }

  loadSubCategories() {
    switch (categoryNumber) {
      case 1:
        {
          getSubCategories(
            parent: 153,
            subCategoriesLst: speakerSubCategoriesLst,
            subCategoriesImgLst: speakerSubCategoriesImgLst,
          );
          break;
        } //اسپیکر
      case 2:
        {
          getSubCategories(
            parent: 1809,
            subCategoriesLst: computerAccessoriesSubCategoriesLst,
            subCategoriesImgLst: computerAccessoriesSubCategoriesImgLst,
          );

          break;
        } // لوازم جانبی کامپیوتر
      case 3:
        {
          getSubCategories(
            parent: 54,
            subCategoriesLst: hardwareComputerSubCategoriesLst,
            subCategoriesImgLst: hardwareComputerSubCategoriesImgLst,
          );
          break;
        } // سخت افزار کامپیوتر
      case 4:
        {
          getSubCategories(
            parent: 1818,
            subCategoriesLst: laptopAccessoriesSubCategoriesLst,
            subCategoriesImgLst: laptopAccessoriesSubCategoriesImgLst,
          );
          break;
        } // لوازم جانبی لپ تاپ
      case 5:
        {
          getSubCategories(
            parent: 158,
            subCategoriesLst: headphoneHandsfreeSubCategoriesLst,
            subCategoriesImgLst: headphoneHandsfreeSubCategoriesImgLst,
          );
          break;
        } // هدفون و هندزفری
      case 6:
        {
          getSubCategories(
            parent: 1601,
            subCategoriesLst: storageEquipmentSubCategoriesLst,
            subCategoriesImgLst: storageEquipmentSubCategoriesImgLst,
          );
          break;
        } // تجهیزات ذخیره سازی
      // case 6:
      //   {
      //     getSubCategories(
      //       parent: 153,
      //       subCategoriesLst: networkEquipmentSubCategoriesLst,
      //       subCategoriesImgLst: networkEquipmentSubCategoriesImgLst,
      //     );
      //     break;
      //   } // تجهیزات شبکه
      default:
        {
          setState(() {
            showContent = true;
          });
          break;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    getParentCategories();
  }

  onRefresh() async {
    setState(() {
      parentCategoriesLst.clear();
      parentCategoriesImgLst.clear();
      speakerSubCategoriesLst.clear();
      speakerSubCategoriesImgLst.clear();
      computerAccessoriesSubCategoriesLst.clear();
      computerAccessoriesSubCategoriesImgLst.clear();
      hardwareComputerSubCategoriesLst.clear();
      hardwareComputerSubCategoriesImgLst.clear();
      laptopAccessoriesSubCategoriesLst.clear();
      laptopAccessoriesSubCategoriesImgLst.clear();
      headphoneHandsfreeSubCategoriesLst.clear();
      headphoneHandsfreeSubCategoriesImgLst.clear();
      storageEquipmentSubCategoriesLst.clear();
      storageEquipmentSubCategoriesImgLst.clear();
      networkEquipmentSubCategoriesLst.clear();
      networkEquipmentSubCategoriesImgLst.clear();
      categoryNumber = 1;
      showContent = false;
    });
    getParentCategories();
    await Future<void>.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return CategoriesView(
      context: context,
      onRefresh: onRefresh,
      parentCategoriesLst: parentCategoriesLst,
      parentCategoriesImgLst: parentCategoriesImgLst,
      speakerSubCategoriesLst: speakerSubCategoriesLst,
      speakerSubCategoriesImgLst: speakerSubCategoriesImgLst,
      computerAccessoriesSubCategoriesLst: computerAccessoriesSubCategoriesLst,
      computerAccessoriesSubCategoriesImgLst: computerAccessoriesSubCategoriesImgLst,
      hardwareComputerSubCategoriesLst: hardwareComputerSubCategoriesLst,
      hardwareComputerSubCategoriesImgLst: hardwareComputerSubCategoriesImgLst,
      laptopAccessoriesSubCategoriesLst: laptopAccessoriesSubCategoriesLst,
      laptopAccessoriesSubCategoriesImgLst: laptopAccessoriesSubCategoriesImgLst,
      headphoneHandsfreeSubCategoriesLst: headphoneHandsfreeSubCategoriesLst,
      headphoneHandsfreeSubCategoriesImgLst: headphoneHandsfreeSubCategoriesImgLst,
      storageEquipmentSubCategoriesLst: storageEquipmentSubCategoriesLst,
      storageEquipmentSubCategoriesImgLst: storageEquipmentSubCategoriesImgLst,
      networkEquipmentSubCategoriesLst: networkEquipmentSubCategoriesLst,
      networkEquipmentSubCategoriesImgLst: networkEquipmentSubCategoriesImgLst,
      showContent: showContent,
    );
  }
}
