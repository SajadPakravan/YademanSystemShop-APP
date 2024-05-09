import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/tools/app_colors.dart';

// ignore: must_be_immutable
class HomeMenu extends StatelessWidget {
  HomeMenu({
    required this.context,
    super.key,
  });

  BuildContext context;
  AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      children: [
        menu(icon: Icons.info_outlined, title: "درباره ما", onTap: () {}),
        menu(icon: Icons.call_rounded, title: "تماس با ما", onTap: () {}),
        menu(icon: Icons.question_mark_rounded, title: "پرسش‌های متداول", onTap: () {}),
        menu(icon: Icons.gpp_maybe_outlined, title: "مشاوره خرید", onTap: () {}),
        menu(icon: Icons.leaderboard_rounded, title: "نحوه ثبت سفارش", onTap: () {}),
        menu(icon: Icons.assignment_returned, title: "سفارش مونتاژ و اسمبل", onTap: () {}),
        menu(icon: Icons.assignment_returned, title: "سفارش قطعات کامپیوتر", onTap: () {}),
        menu(icon: Icons.assignment_returned, title: "سفارش اجناس استوک", onTap: () {}),
      ],
    );
  }

  menu({
    required String title,
    required IconData icon,
    Color iconColor = Colors.white,
    void Function()? onTap,
  }) {
    double width = MediaQuery.of(context).size.width;
    return Transform.scale(
      scale: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.02),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(39, 60, 117,1.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: width * 0.08,
              ),
            ),
            SizedBox(
              height: width * 0.015,
            ),
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium,
              maxFontSize: 12,
              minFontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
