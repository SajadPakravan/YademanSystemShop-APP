import 'package:flutter/material.dart';

class TextBodyLargeView extends StatelessWidget {
  const TextBodyLargeView(this.data, {super.key, this.color, this.fontSize, this.fontWeight, this.height});

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
          ),
    );
  }
}
