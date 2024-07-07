import 'package:flutter/material.dart';
import 'package:yad_sys/screens/main/profile/sign_in_screen.dart';
import 'package:yad_sys/screens/main/profile/sign_up_screen.dart';
import 'package:yad_sys/views/profile/logged/logged_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.context,
    required this.logged,
    required this.name,
    required this.email,
    required this.logOut,
    required this.pageCtrl,
    required this.checkLogged,
  });

  final BuildContext context;
  final bool logged;
  final String name;
  final String email;
  final Function logOut;
  final PageController pageCtrl;
  final Function() checkLogged;

  @override
  Widget build(BuildContext context) {
    return logged
        ? const LoggedView()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              toolbarHeight: 100,
              title: const Icon(Icons.account_circle, color: Colors.grey, size: 100),
            ),
            body: PageView(
              controller: pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              children: [SignInScreen(pageCtrl: pageCtrl, checkLogged: checkLogged), SignUpScreen(pageCtrl: pageCtrl)],
            ),
          );
  }
}
