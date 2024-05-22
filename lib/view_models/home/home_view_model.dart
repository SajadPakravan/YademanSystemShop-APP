import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_categories_model.dart';
import 'package:yad_sys/models/product_model.dart';

class HomeViewModel with ChangeNotifier {
  final HttpRequest _httpRequest = HttpRequest();
  List<Images> offImgLst = [];
  List<ProductModel> offDetLst = [];
  List<ProductCategoryImage> categoriesImgLst = [];
  List<ProductCategoryModel> categoriesLst = [];
  List<Images> laptopImgLst = [];
  List<ProductModel> laptopDetLst = [];
  List<Images> speakerImgLst = [];
  List<ProductModel> speakerDetLst = [];
  int _dataNumber = 1;
  bool showContent = false;

  set dataNumber(int number) {
    _dataNumber = number;
    notifyListeners();
  }

  int get dataNumber => _dataNumber;

  getProducts({
    String categoryId = '',
    String onSale = '',
    int perPage = 10,
    required List<Images> listProductImage,
    required List<ProductModel> listProductDetail,
  }) async {
    dynamic jsonGetCategoryProducts = await _httpRequest.getProducts(
      category: categoryId,
      onSale: onSale,
      perPage: perPage,
    );

    List jsonProductsImage = [];
    List<Images> pImage = [];

    jsonGetCategoryProducts.forEach((i) {
      jsonProductsImage.add(i['images'][0]);
    });

    for (var image in jsonProductsImage) {
      pImage.add(Images(src: image['src']));
    }

    listProductImage.addAll(pImage);

    List<ProductModel> pDetails = [];
    jsonGetCategoryProducts.forEach((p) {
      pDetails.add(
        ProductModel(
          id: p['id'],
          name: p['name'],
          regularPrice: p['regular_price'],
          salePrice: p['sale_price'],
        ),
      );
    });

    listProductDetail.addAll(pDetails);

    _dataNumber++;
    loadData();
    notifyListeners();
  }

  getParentCategories() async {
    dynamic jsonGetCategories = await _httpRequest.getCategories(
      perPage: 9,
      include: "57,1818,1809,54,153,158,67,1601,1773,51,1816,151",
    );

    List jsonCategoriesImage = [];
    List<ProductCategoryImage> cImage = [];

    jsonGetCategories.forEach((i) {
      jsonCategoriesImage.add(i['image']['src']);
    });

    for (var image in jsonCategoriesImage) {
      cImage.add(ProductCategoryImage(src: image));
    }

    categoriesImgLst = cImage;

    List<ProductCategoryModel> c = [];
    jsonGetCategories.forEach((pc) {
      c.add(
        ProductCategoryModel(
          id: pc['id'],
          name: pc['name'],
        ),
      );
    });

    categoriesLst = c;
    _dataNumber++;
    loadData();
    notifyListeners();
  }

  loadData() {
    switch (_dataNumber) {
      case 1:
        {
          getProducts(
            onSale: "true",
            listProductImage: offImgLst,
            listProductDetail: offDetLst,
          ); // پیشنهاد شگفت انگیز
          break;
        }
      case 2:
        {
          getParentCategories(); // دسته بندی
          break;
        }
      case 3:
        {
          getProducts(
            categoryId: "57",
            perPage: 9,
            listProductImage: laptopImgLst,
            listProductDetail: laptopDetLst,
          ); // لپ تاپ
          break;
        }
      case 4:
        {
          getProducts(
            categoryId: "153",
            perPage: 9,
            listProductImage: speakerImgLst,
            listProductDetail: speakerDetLst,
          ); // اسپیکر
          break;
        }
      default:
        {
          showContent = true;
          notifyListeners();
          break;
        }
    }
  }
}
