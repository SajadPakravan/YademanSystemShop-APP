import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileOptionCard extends StatelessWidget {
  ProfileOptionCard({
    super.key,
    required this.title,
    required this.iconPath,
    this.checkParam = false,
    required this.onTap,
  });

  String title;
  String iconPath;
  bool checkParam;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Stack(
          children: [
            Container(
              width: 90,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xffc9f8ff),
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(iconPath, height: 50),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: checkParam,
              child: const Icon(Icons.circle, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
