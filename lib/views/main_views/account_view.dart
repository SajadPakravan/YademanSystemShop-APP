import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/screens/main/profile/sign_in_screen.dart';
import 'package:yad_sys/screens/main/profile/sign_up_screen.dart';
import 'package:yad_sys/tools/app_colors.dart';
import 'package:yad_sys/tools/app_themes.dart';
import 'package:yad_sys/widgets/tree_button/tree_button.dart';
import 'package:yad_sys/widgets/tree_button/tree_button_list.dart';

// ignore: must_be_immutable
class AccountView extends StatelessWidget {
  AccountView({
    required this.context,
    required this.logged,
    required this.name,
    required this.email,
    required this.logOut,
    required this.pageCtrl,
    required this.onTapButton,
    required this.subAccHeight,
    required this.subAddHeight,
    super.key,
  });

  BuildContext context;
  dynamic logged;
  String name;
  String email;
  Function logOut;
  PageController pageCtrl;
  AppColors appColors = AppColors();
  Function onTapButton;
  double subAccHeight;
  double subAddHeight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return logged == ""
        ? Center(child: LoadingAnimationWidget.threeArchedCircle(color: Colors.black54, size: width * 0.1))
        : logged
            ? loggedContent()
            : notLoggedContent();
  }

  loggedContent() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        appBar(),
      ],
      body: TreeButtonList(
        onTapButton: onTapButton,
        buttons: [
          TreeButton(
            title: "اطلاعات حساب کاربری",
            subButtons: [
              TreeButton(title: "gfergug55"),
              TreeButton(title: "tr3h74ihgeg5gg"),
              TreeButton(title: "44tt3itjif34", subButtons: [TreeButton(title: "788ff")],subHeight: subAddHeight),
              TreeButton(title: "t34t439guf9ujg0"),
            ],
            subHeight: subAccHeight,
          ),
          TreeButton(title: "سبد خرید"),
          TreeButton(
            title: "آدرس‌ها",
            subButtons: [TreeButton(title: "آدرس صورتحساب"), TreeButton(title: "آدرس ارسال بار")],
            subHeight: subAddHeight,
          ),
          TreeButton(title: "سفارش‌ها"),
          TreeButton(title: "پیگیری سفارش"),
          TreeButton(title: "دیدگاه‌ها"),
          TreeButton(title: "علاقه‌مندی‌ها"),
          TreeButton(title: "خروج از حساب کاربری"),
        ],
      ),
    );
  }

  appBar() {
    double width = MediaQuery.of(context).size.width;
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
      elevation: 5,
      toolbarHeight: 150,
      flexibleSpace: Container(
        color: appColors.blueFav,
        padding: EdgeInsets.all(width * 0.03),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.settings),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_rounded, color: Colors.white, size: width * 0.2),
                  Text(name, style: Theme.of(context).textTheme.buttonText1),
                  Text(email, style: Theme.of(context).textTheme.buttonText1),
                ],
              ),
              const Icon(Icons.call_rounded),
            ],
          ),
        ),
      ),
    );
  }

  notLoggedContent() {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: pageCtrl,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SignInScreen(pageCtrl: pageCtrl),
          SignUpScreen(pageCtrl: pageCtrl),
        ],
      ),
    );
  }

  topCover() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width,
        height: height * 0.3,
        color: appColors.blueFav,
        child: Icon(Icons.account_circle_rounded, color: Colors.white, size: width * 0.2));
  }
}
