import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.9,
      padding: EdgeInsets.zero,
      children: [
        HomeMenuItem(icon: Icons.info_rounded, title: "درباره ما", onTap: () {}),
        HomeMenuItem(icon: Icons.phone, title: "تماس با ما", onTap: () {}),
        HomeMenuItem(icon: Icons.question_mark_rounded, title: "پرسش‌های متداول", onTap: () {}),
        HomeMenuItem(icon: Icons.shopping_bag, title: "سفارش خاص", onTap: () {}),
      ],
    );
  }
}

class HomeMenuItem extends StatefulWidget {
  const HomeMenuItem({super.key, required this.title, required this.icon, this.onTap});

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  State<HomeMenuItem> createState() => _HomeMenuItemState();
}

class _HomeMenuItemState extends State<HomeMenuItem> {
  bool _isTapped = false;

  void _handleTap() {
    setState(() => _isTapped = true);
    Future.delayed(const Duration(milliseconds: 100), () => setState(() => _isTapped = false));
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isTapped ? Colors.black26 : const Color(0xff0353a4),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(widget.icon, color: const Color(0xffcaf0f8), size: 40),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: TextBodyMediumView(widget.title, textAlign: TextAlign.center, maxLines: 2),
            ),
          ),
        ],
      ),
    );
  }
}
