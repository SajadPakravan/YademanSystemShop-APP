import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/themes/text_styles.dart';

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: colorScheme(),
  fontFamily: "IranYekan",
  primaryColor: ColorStyle.colorPurpleDark,
  scaffoldBackgroundColor: ColorStyle.colorBlack1b,
  canvasColor: ColorStyle.colorBlack24,
  cardColor: ColorStyle.colorBlack0a,
  focusColor: ColorStyle.colorPurple,
  textTheme: const TextTheme(
    headlineLarge: TextStylesDark.whiteF25,
    titleLarge: TextStylesDark.whiteF20,
    titleMedium: TextStylesDark.whiteF18,
    titleSmall: TextStylesDark.whiteF16,
    bodyLarge: TextStylesDark.whiteF16,
    bodyMedium: TextStylesDark.whiteF14,
    bodySmall: TextStylesDark.whiteF12,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 12),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyle.colorPurple)),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: ColorStyle.colorBlack24),
  bottomNavigationBarTheme: bottomNavigationBarTheme(),
  appBarTheme: const AppBarTheme(backgroundColor: ColorStyle.colorPurpleDark),
  iconTheme: const IconThemeData(color: ColorStyle.colorWhite),
  elevatedButtonTheme: elevatedButtonTheme(),
);

colorScheme() {
  return const ColorScheme.dark(
    primary: ColorStyle.colorPurple,
    background: ColorStyle.colorBlack1b,
  );
}

bottomNavigationBarTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: ColorStyle.colorBlack1b,
    selectedItemColor: ColorStyle.colorPurple2,
    selectedIconTheme: IconThemeData(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.blue),
    selectedLabelStyle: TextStylesDark.whiteF14,
  );
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      backgroundColor: MaterialStateProperty.all(ColorStyle.colorPurpleDark),
      textStyle: MaterialStateProperty.all(TextStylesDark.whiteF18),
    ),
  );
}
