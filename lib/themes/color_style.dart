import 'package:flutter/material.dart';
import 'package:yad_sys/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorStyle {
  static const Color darkBlue = Color(0xff03045e);
  static const Color colorPurple = Color.fromARGB(255, 65, 96, 245);
  static const Color colorPurple2 = Color.fromARGB(255, 46, 67, 169);
  static const Color colorPurpleDark = Color(0xff0b1e64);
  static const Color colorPurpleDarkBorder = Color(0xff2b43a4);
  static const Color colorBlack0a = Color(0xff0a0f14);
  static const Color colorWhiteE7 = Color(0xffe7edef);
  static const Color colorBlack13 = Color(0xff131b25);
  static const Color whiteF5 = Color(0xfff5f5f5);
  static const Color colorBlack1b = Color(0xff1b2936);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorBlack24 = Color(0xff243547);
  static const Color colorYellow = Color(0xffffc107);
  static const Color colorPink = Color(0xffbb074f);
  static const Color colorPinkF9 = Color(0xfff94e4e);
  static const Color colorOrange = Color(0xffff8b29);
  static const Color colorGreen = Color(0xff05d157);
  static const Color colorGreenLight = Color(0xff80ffb2);
  static const Color colorRed = Color(0xffff0000);
  static const Color colorBlue = Color(0xff00dbff);
  static const Color colorBlueLight = Color(0xff8be7fa);
  static const Color colorBlue1 = Color(0xff1d5093);
  static const Color colorBlue2 = Color(0x351d5093);
  static const Color colorFont42 = Color(0xff424242);
  static const Color colorWhiteCB = Color(0xffcbcbcb);
  static const Color colorGrey = Color(0xffa2a2a2);
  static const Color colorWhiteGR = Color(0xffe3e3e3);
  static const Color colorGrayB4 = Color(0xffcccccc);
  static const Color colorPinkApp = Color(0xffff00ce);
  static const Color colorPinkBack = Color(0xffff7be6);
  static const Color backgroundItemColorDashboardUnSelected = Color.fromRGBO(196, 196, 196, 1.0);
  static const Color backgroundColorDashboard = Color.fromRGBO(249, 249, 249, 1.0);

  static changer({required BuildContext context, required Color lightColor, required Color darkColor}) {
    switch(Provider.of<ThemeProvider>(context, listen: false).themeMode) {
      case ThemeMode.system: {
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.light ? lightColor : darkColor;
      }
      case ThemeMode.light: {
        return lightColor;
      }
      case ThemeMode.dark: {
        return darkColor;
      }
    }
  }
}