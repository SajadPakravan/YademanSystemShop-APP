import 'package:flutter/material.dart';
import 'package:yad_sys/widgets/tree_button/sub_tree_btn.dart';
import 'package:yad_sys/widgets/tree_button/tree_button.dart';

// ignore: must_be_immutable
class TreeButtonList extends StatelessWidget {
  TreeButtonList({
    required this.buttons,
    required this.onTapButton,
    super.key,
  });

  List<TreeButton> buttons;
  Function onTapButton;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      primary: false,
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        TreeButton treeButton = buttons[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                onTapButton(index);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
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
            ),
            SubTreeButtons(
              buttons: treeButton.subButtons,
              subHeight: treeButton.subHeight,
            ),
          ],
        );
      },
    );
  }
}
