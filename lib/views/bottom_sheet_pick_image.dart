import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';

bottomSheetPickImage({
  required BuildContext context,
  required Function() onTapCamera,
  required Function() onTapGallery,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorStyle.changer(
      context: context,
      lightColor: ColorStyle.colorWhite,
      darkColor: ColorStyle.colorFont42,
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            option(
              context: context,
              icon: Icons.camera_alt_rounded,
              title: 'Camera',
              onTap: onTapCamera,
            ),
            option(
              context: context,
              icon: Icons.photo,
              title: 'Gallery',
              onTap: onTapGallery,
            ),
          ],
        ),
      );
    },
  );
}

option({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 108,
      width: 108,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).iconTheme.color!, width: 0.1),
        color: ColorStyle.changer(
          context: context,
          lightColor: ColorStyle.colorWhite,
          darkColor: ColorStyle.colorFont42,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: ColorStyle.colorPurple,
          ),
          const SizedBox(height: 5),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    ),
  );
}
