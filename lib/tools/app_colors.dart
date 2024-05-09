import 'package:flutter/material.dart';

class AppColors {
  Color gray12 = const Color.fromRGBO(225, 229, 232, 1);
  Color opacity0 = const Color.fromRGBO(225, 229, 232, 0.01);
  Gradient gradientBlue = const LinearGradient(
    colors: [
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  Color progressColor = Colors.black45;

  MaterialColor blueFav = const MaterialColor(
    0xff3366cc,
    <int, Color>{
      50: Color(0xff3366cc),
      100: Color(0xff3366cc),
      200: Color(0xff3366cc),
      300: Color(0xff3366cc),
      400: Color(0xff3366cc),
      500: Color(0xff3366cc),
      600: Color(0xff3366cc),
      700: Color(0xff3366cc),
      800: Color(0xff3366cc),
      900: Color(0xff3366cc),
    },
  );
}