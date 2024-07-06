import 'package:flutter/material.dart';
import 'package:yad_sys/screens/main/profile/sign_in_screen.dart';
import 'package:yad_sys/screens/main/profile/sign_up_screen.dart';

class AccountView extends StatelessWidget {
  const AccountView({
    super.key,
    required this.context,
    required this.logged,
    required this.name,
    required this.email,
    required this.logOut,
    required this.pageCtrl,
    required this.onTapButton,
    required this.subAccHeight,
    required this.subAddHeight,
  });

  final BuildContext context;
  final bool logged;
  final String name;
  final String email;
  final Function logOut;
  final PageController pageCtrl;
  final Function onTapButton;
  final double subAccHeight;
  final double subAddHeight;

  @override
  Widget build(BuildContext context) {
    return logged ? loggedContent() : notLoggedContent();
  }

  loggedContent() {
    return;
  }

  notLoggedContent() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: const Icon(Icons.account_circle, color: Colors.grey, size: 100),
      ),
      body: PageView(
        controller: pageCtrl,
        physics: const NeverScrollableScrollPhysics(),
        children: [SignInScreen(pageCtrl: pageCtrl), SignUpScreen(pageCtrl: pageCtrl)],
      ),
    );
  }
}
