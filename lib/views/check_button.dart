import 'package:flutter/material.dart';
import 'package:yad_sys/themes/color_style.dart';

// ignore: must_be_immutable
class CheckButton extends StatefulWidget {
  int index;
  List itemsList;
  List selectedIndexes;

  CheckButton({
    super.key,
    required this.index,
    required this.itemsList,
    required this.selectedIndexes,
  });

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  ColorStyle colorStyle = ColorStyle();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: widget.selectedIndexes.contains(widget.index + 1)
          ? ColorStyle.changer(
              context: context,
              lightColor: ColorStyle.colorPurple,
              darkColor: ColorStyle.colorPurpleDark,
            )
          : ColorStyle.changer(
              context: context,
              lightColor: ColorStyle.colorWhite,
              darkColor: ColorStyle.backgroundItemColorDashboardUnSelected,
            ),
      child: Text(
        widget.itemsList[widget.index],
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: widget.selectedIndexes.contains(widget.index + 1) ? Colors.white : Colors.black,
            ),
      ),
      onPressed: () {
        if (widget.selectedIndexes.contains(widget.index + 1)) {
          setState(() {
            widget.selectedIndexes.remove(widget.index + 1);
          });
        } else if (widget.selectedIndexes.length != 3) {
          setState(() {
            widget.selectedIndexes.add(widget.index + 1);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("حداکثر ۳ پست را می‌توانید انتخاب کنید"),
          ));
        }
      },
    );
  }
}
