import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_category_model.dart';
import 'package:yad_sys/models/product_model.dart';

class HomeViewModel with ChangeNotifier {
  final HttpRequest _httpRequest = HttpRequest();
  List<ProductModel> discountLst = [];
  List<ProductCategoryModel> categoriesLst = [];
  List<ProductModel> laptopLst = [];
  List<ProductModel> speakerLst = [];
  int _dataNumber = 1;
  bool showContent = false;

  set dataNumber(int number) {
    _dataNumber = number;
    notifyListeners();
  }

  int get dataNumber => _dataNumber;

  getProducts({String categoryId = '', String onSale = '', int perPage = 10, required List<ProductModel> list}) async {
    dynamic jsonProducts = await _httpRequest.getProducts(category: categoryId, onSale: onSale, perPage: perPage);
    jsonProducts.forEach((p) => list.add(ProductModel.fromJson(p)));
    _dataNumber++;
    loadData();
    notifyListeners();
  }

  getParentCategories() async {
    dynamic jsonCategories = await _httpRequest.getCategories(perPage: 9, include: "57,1818,1809,54,153,158,67,1601,1773,51,1816,151");
    jsonCategories.forEach((c) => categoriesLst.add(ProductCategoryModel.fromJson(c)));
    _dataNumber++;
    loadData();
    notifyListeners();
  }

  loadData() {
    switch (_dataNumber) {
      case 1:
        {
          getProducts(onSale: 'true', list: discountLst);
          break;
        }
      case 2:
        {
          getParentCategories();
          break;
        }
      case 3:
        {
          getProducts(categoryId: "57", perPage: 9, list: laptopLst);
          break;
        }
      case 4:
        {
          getProducts(categoryId: "153", perPage: 9, list: speakerLst);
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
