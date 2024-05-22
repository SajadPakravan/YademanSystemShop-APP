import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/screens/search/search_screen.dart';
import 'package:yad_sys/themes/app_themes.dart';

class SearchNav extends StatelessWidget {
  const SearchNav({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: width * 0.02),
              child: const Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),
            Text(
              "جستجو در ",
              style: Theme.of(context).textTheme.hintText,
            ),
            Text(
              "یادمان سیستم",
              style: Theme.of(context).textTheme.yadsys,
            ),
          ],
        ),
      ),
      onTap: () {
        Get.to(
          const SearchScreen(),
          transition: Transition.upToDown,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
