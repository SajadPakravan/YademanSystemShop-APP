import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';

class TextStylesLight {
  static const TextStyle blackF12 = TextStyle(
    color: ColorStyle.colorBlack0a,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  static const TextStyle blackF14 = TextStyle(
    color: ColorStyle.colorBlack0a,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static const TextStyle blackF16 = TextStyle(
    color: ColorStyle.colorBlack0a,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  static const TextStyle blackF18 = TextStyle(
    color: ColorStyle.colorBlack0a,
    fontWeight: FontWeight.normal,
    fontSize: 18,
  );

  static const TextStyle blackF20 = TextStyle(
    color: ColorStyle.colorBlack0a,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );

  static const TextStyle blackF25 = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.normal,
    fontSize: 25,
  );
}

class TextStylesDark {
  static const TextStyle whiteF12 = TextStyle(
    color: ColorStyle.colorWhite,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  static const TextStyle whiteF14 = TextStyle(
    color: ColorStyle.colorWhite,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static const TextStyle whiteF16 = TextStyle(
    color: ColorStyle.colorWhite,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  static const TextStyle whiteF18 = TextStyle(
    color: ColorStyle.colorWhite,
    fontWeight: FontWeight.normal,
    fontSize: 18,
  );

  static const TextStyle whiteF20 = TextStyle(
    color: ColorStyle.colorWhite,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );

  static const TextStyle whiteF25 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 25,
  );
}

extension TextStyles on TextTheme {
  TextStyle get titleWhite30 {
    return const TextStyle(
      color: Colors.white,
      fontFamily: "IranYekan",
      fontWeight: FontWeight.normal,
      fontSize: 30,
    );
  }

  TextStyle get titleWhiteBoldF18 {
    return const TextStyle(
      color: Colors.white,
      fontFamily: "IranYekan",
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  TextStyle get subTileWhite18 {
    return const TextStyle(
      color: Color.fromARGB(255, 160, 180, 250),
      fontFamily: "IranYekan",
      fontWeight: FontWeight.normal,
      fontSize: 18,
    );
  }

  TextStyle get subTitleBlackF16 {
    return const TextStyle(
      color: Colors.black54,
      fontFamily: "IranYekan",
      fontWeight: FontWeight.normal,
      fontSize: 18,
    );
  }

  TextStyle get btnSemiBoldDarkGrey18 {
    return const TextStyle(
      color: Color.fromARGB(255, 3, 65, 116),
      fontFamily: "IranYekan",
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );
  }

  TextStyle get btnWhite14 {
    return const TextStyle(
      color: Colors.white,
      fontFamily: "IranYekan",
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }
}
