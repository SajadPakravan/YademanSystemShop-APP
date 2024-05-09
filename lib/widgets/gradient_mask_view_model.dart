import 'package:flutter/material.dart';
import 'package:yad_sys/tools/app_colors.dart';

class GradientMaskViewModel extends StatefulWidget {
  const GradientMaskViewModel({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<GradientMaskViewModel> createState() => _GradientMaskViewModelState();
}

class _GradientMaskViewModelState extends State<GradientMaskViewModel> {
  AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => appColors.gradientBlue.createShader(bounds),
      child: widget.child,
    );
  }
}
