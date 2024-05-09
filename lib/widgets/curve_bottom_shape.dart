import 'package:flutter/material.dart';

class CurveTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(0, height / 5);

    Offset pointStart1 = Offset(width / 5, height / 3.5);
    Offset pointEnd1 = Offset(width / 2, height / 3.5);
    path.quadraticBezierTo(pointStart1.dx, pointStart1.dy, pointEnd1.dx, pointEnd1.dy);

    Offset pointStart2 = Offset(width - width / 5, height / 3.5);
    Offset pointEnd2 = Offset(width, height / 5);
    path.quadraticBezierTo(pointStart2.dx, pointStart2.dy, pointEnd2.dx, pointEnd2.dy);

    path.lineTo(width, height);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
