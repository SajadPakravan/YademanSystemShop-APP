import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';

class ButtonSwitch extends StatelessWidget {
  ButtonSwitch({
    super.key,
    required this.context,
    required this.titleRight,
    required this.iconRight,
    required this.checkRight,
    required this.onTapRight,
    required this.titleLeft,
    required this.iconLeft,
    required this.checkLeft,
    required this.onTapLeft,
    required this.pick,
  });

  final BuildContext context;
  final String titleRight;
  final String iconRight;
  final int checkRight;
  final String titleLeft;
  final String iconLeft;
  final int checkLeft;
  final int pick;
  final Function() onTapRight;
  final Function() onTapLeft;

  final ColorStyle colorStyle = ColorStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorStyle.changer(
          context: context,
          lightColor: ColorStyle.colorWhite,
          darkColor: ColorStyle.colorBlack24,
        ),
      ),
      child: Row(
        children: [
          switchOption(
            title: titleRight,
            iconPath: iconRight,
            color: pick == checkRight
                ? ColorStyle.colorPurple
                : ColorStyle.changer(
                    context: context,
                    lightColor: ColorStyle.colorWhite,
                    darkColor: ColorStyle.colorBlack24,
                  ),
            checkOption: checkRight,
            onTap: onTapRight,
          ),
          switchOption(
            title: titleLeft,
            iconPath: iconLeft,
            color: pick == checkLeft
                ? ColorStyle.colorPurple
                : ColorStyle.changer(
                    context: context,
                    lightColor: ColorStyle.colorWhite,
                    darkColor: ColorStyle.colorBlack24,
                  ),
            checkOption: checkLeft,
            onTap: onTapLeft,
          ),
        ],
      ),
    );
  }

  switchOption({
    required String title,
    required String iconPath,
    required Color color,
    required int checkOption,
    required Function() onTap,
  }) {
    return Flexible(
      flex: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 35),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: pick == checkOption
                              ? Colors.white
                              : ColorStyle.changer(
                                  context: context,
                                  lightColor: ColorStyle.colorBlack0a,
                                  darkColor: ColorStyle.backgroundItemColorDashboardUnSelected,
                                ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
