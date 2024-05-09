import 'package:flutter/material.dart';
import 'package:yad_sys/widgets/tree_button/tree_button.dart';

// ignore: must_be_immutable
class SubTreeButtons extends StatelessWidget {
  SubTreeButtons({
    this.buttons = const [],
    required this.subHeight,
    super.key,
  });

  List<TreeButton> buttons;
  double subHeight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: buttons.length * (width * subHeight),
        child: ListView.builder(
          itemCount: buttons.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (context, index) {
            TreeButton treeButton = buttons[index];
            return InkWell(
              child: Container(
                padding: EdgeInsets.only(right: width / 7, top: 20, bottom: 20, left: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      treeButton.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black54,
                      size: width * 0.07,
                    ),
                  ],
                ),
              ),
              onTap: () {
                print("Click >>> ${treeButton.title}");
              },
            );
          },
        ),
      ),
    );
  }
}
