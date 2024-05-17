import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';

class GradientMaskViewModel extends StatefulWidget {
  const GradientMaskViewModel({super.key, required this.child});
  final Widget child;

  @override
  State<GradientMaskViewModel> createState() => _GradientMaskViewModelState();
}

class _GradientMaskViewModelState extends State<GradientMaskViewModel> {

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => ColorStyle.gradientBlue.createShader(bounds),
      child: widget.child,
    );
  }
}
