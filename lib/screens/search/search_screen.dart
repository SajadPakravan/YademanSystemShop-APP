import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/product_model.dart';
import 'package:yad_sys/themes/app_themes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  HttpRequest httpRequest = HttpRequest();
  List<ProductModel> productDetailList = [];
  List<Images> productImageList = [];

  getSearchProducts(String search) async {
    dynamic jsonGetSearchProducts = await httpRequest.getSearchProduct(
      search: search,
    );
    switch (jsonGetSearchProducts) {
      case false:
        {
          break;
        }
      case "empty":
        {

          break;
        }
      default:
        {
          setState(() {
            productImageList.clear();
            productDetailList.clear();
          });
          List jsonProductsImages = [];

          jsonGetSearchProducts.forEach((i) {
            setState(() {
              jsonProductsImages.add(i['images'][0]);
            });
          });

          print("jsonProductsImages >>>: $jsonProductsImages");

          for (var image in jsonProductsImages) {
            setState(() {
              productImageList.add(Images(src: image['src']));
            });
          }

          jsonGetSearchProducts.forEach((p) {
            setState(() {
              productDetailList.add(
                ProductModel(
                  id: p['id'],
                  name: p['name'],
                  regularPrice: p['regular_price'],
                  price: p['sale_price'],
                ),
              );
            });
          });
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black54,
      ),
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          decoration: InputDecoration(
            hintText: "محصول مورد نظر را جستجو کنید ...",
            prefixIcon: const Icon(Icons.search_rounded),
            hintStyle: Theme.of(context).textTheme.hintText,
          ),
          onChanged: (value) {
            if (value.length > 3) {
              // getSearchProducts(value);
            } else if (value.isEmpty) {
              // getSearchProducts(value);
            }
          },
        ),
      ),
    );
  }
}
