import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';

// ignore: must_be_immutable
class RadioContainer extends StatelessWidget {
  String title;
  IconData iconData;
  int isRadioCheck;
  int value;
  void Function() onTap;

  RadioContainer({
    super.key,
    required this.title,
    required this.iconData,
    required this.isRadioCheck,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle.changer(
            context: context,
            lightColor: isRadioCheck == value ? Colors.black38 : Colors.grey.shade100,
            darkColor: isRadioCheck == value ? Colors.white70 : Colors.black12,
          ),
          boxShadow: [
            BoxShadow(color: Theme.of(context).canvasColor, spreadRadius: 3),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: ColorStyle.changer(
                    context: context,
                    lightColor: Colors.black87,
                    darkColor: isRadioCheck == value ? Colors.black87 : Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                iconData,
                color: ColorStyle.changer(
                  context: context,
                  lightColor: Colors.black87,
                  darkColor: isRadioCheck == value ? Colors.black87 : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
