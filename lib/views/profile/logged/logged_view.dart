import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_small_view.dart';

class LoggedView extends StatelessWidget {
  const LoggedView({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
    required this.signOut,
    required this.personalInfoAlert,
    required this.addressAlert,
  });

  final String name;
  final String email;
  final String avatar;
  final void Function() signOut;
  final bool personalInfoAlert;
  final bool addressAlert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 150 / 2, backgroundImage: CachedNetworkImageProvider(avatar)),
                const SizedBox(height: 10),
                TextBodyLargeView(name),
                const SizedBox(height: 10),
                TextBodyMediumView(email),
                const SizedBox(height: 20),
                option(
                  title: 'مشخصات فردی',
                  icon: Icons.person,
                  subtitle: personalInfoAlert ? const TextBodySmallView('لطفا مشخصات فردی خود را تکمیل کنید', color: Colors.red) : null,
                  onTap: () {},
                ),
                option(
                  title: 'آدرس‌ها',
                  icon: Icons.location_on,
                  subtitle: addressAlert ? const TextBodySmallView('لطفا آدرس خود را وارد کنید', color: Colors.red) : null,
                  onTap: () {},
                ),
                option(title: 'سبد خرید', icon: Icons.shopping_cart, onTap: () {}),
                option(title: 'علاقه‌مندی‌ها', icon: Icons.favorite, onTap: () {}),
                option(title: 'سفارشات', icon: Icons.shopping_bag, onTap: () {}),
                option(title: 'تماس با پشتیبانی', icon: Icons.headphones, onTap: () {}),
                option(title: 'خروج از حساب کاربری', icon: Icons.logout, onTap: signOut),
              ],
            ),
          ),
        ),
      ),
    );
  }

  option({required String title, required IconData icon, Widget? subtitle, required void Function() onTap}) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        title: TextBodyMediumView(title),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward_ios),
        subtitle: subtitle,
        onTap: onTap,
      ),
    );
  }
}
