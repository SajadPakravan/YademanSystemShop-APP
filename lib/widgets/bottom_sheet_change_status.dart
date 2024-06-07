import 'package:flutter/material.dart';

bottomSheetCategories({
  required BuildContext context,
  int? selected,
  required Function() onTapConfirmed,
  required Function() onTapFailed,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                option(
                  context: context,
                  title: "8888888",
                  selected: selected,
                  value: 1,
                  onTap: onTapConfirmed,
                ),
                option(
                  context: context,
                  title: "999999",
                  selected: selected,
                  value: 2,
                  onTap: onTapFailed,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

option({
  required BuildContext context,
  required String title,
  required int? selected,
  required int value,
  required Function() onTap,
}) {
  return ListTile(
    title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
    leading: Radio<int>(
      value: value,
      groupValue: selected,
      onChanged: (int? value) {
        selected = value!;
        onTap();
        Navigator.pop(context);
      },
    ),
  );
}