import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/screens/main/profile/address/address_screen.dart';
import 'package:yad_sys/screens/main/profile/personal_info/personal_info_screen.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_small_view.dart';

class LoggedView extends StatelessWidget {
  const LoggedView({
    super.key,
    required this.customer,
    required this.getCustomer,
    required this.signOut,
    required this.personalInfoAlert,
    required this.addressAlert,
  });

  final CustomerModel customer;
  final Function() getCustomer;
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
                CircleAvatar(radius: 150 / 2, backgroundImage: CachedNetworkImageProvider(customer.avatarUrl!)),
                const SizedBox(height: 10),
                TextBodyLargeView('${customer.firstName} ${customer.lastName}'),
                const SizedBox(height: 10),
                TextBodyMediumView(customer.email!),
                const SizedBox(height: 20),
                option(
                  title: 'مشخصات فردی',
                  icon: Icons.person,
                  subtitle: personalInfoAlert ? const TextBodySmallView('لطفا مشخصات فردی خود را تکمیل کنید', color: Colors.red) : null,
                  onTap: () async {
                    await Get.to(
                      const PersonalInfoScreen(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                      arguments: customer,
                    );
                    getCustomer();
                  },
                ),
                option(
                  title: 'آدرس‌',
                  icon: Icons.location_on,
                  subtitle: addressAlert ? const TextBodySmallView('لطفا آدرس خود را وارد کنید', color: Colors.red) : null,
                  onTap: () async {
                    await Get.to(
                      const AddressScreen(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                      arguments: customer,
                    );
                    getCustomer();
                  },
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        title: TextBodyMediumView(title),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward_ios),
        subtitle: subtitle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onTap: onTap,
      ),
    );
  }
}
