import 'package:yad_sys/screens/main/shop/shop_screen.dart';
import 'package:flutter/material.dart';

class MainViewModel {
  ShopScreenState shopScreenState = ShopScreenState();
  IconData icnHome = Icons.home;
  IconData icnShop = Icons.store_outlined;
  IconData icnCategory = Icons.category_outlined;
  IconData icnAccount = Icons.person_outlined;

  onTapMenu({required int index}) {
    switch (index) {
      case 0:
        {
          menuSelected();
          icnHome = Icons.home;
          break;
        }
      case 1:
        {
          menuSelected();
          icnShop = Icons.store;
          break;
        }
      case 2:
        {
          menuSelected();
          icnCategory = Icons.category;
          break;
        }
      case 3:
        {
          menuSelected();
          icnAccount = Icons.person;
          break;
        }
    }
  }

  menuSelected() {
    icnHome = Icons.home_outlined;
    icnShop = Icons.store_outlined;
    icnCategory = Icons.category_outlined;
    icnAccount = Icons.person_outlined;
  }
}
