import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/views/account_views/sign_in_view.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.pageCtrl});

  final PageController pageCtrl;

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  HttpRequest httpRequest = HttpRequest();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  bool obscureText = true;
  bool showPass = false;
  bool emailErrVis = false;
  String emailErrStr = "";
  bool passErrVis = false;
  String passErrStr = "";

  showPassFun(v) {
    if (v) {
      setState(() {
        showPass = v;
        obscureText = false;
      });
    } else {
      setState(() {
        showPass = v;
        obscureText = true;
      });
    }
  }

  signInFun() async {
    setState(() {
      emailErrVis = false;
      passErrVis = false;
    });

    if (emailCtrl.text.isEmpty) {
      setState(() {
        emailErrVis = true;
        emailErrStr = 'لطفا ایمل را وارد کنید';
      });
    } else {
      if (!EmailValidator.validate(emailCtrl.text, true)) {
        setState(() {
          emailErrVis = true;
          emailErrStr = 'ایمیل وارد شده معتبر نیست';
        });
      }
    }

    if (passCtrl.text.isEmpty) {
      setState(() {
        passErrVis = true;
        passErrStr = 'لطفا کلمه عبور را وارد کنید';
      });
    }

    if (!emailErrVis && !passErrVis) {
      if (mounted) {
        dynamic jsonSignIn = await httpRequest.signIn(context: context, email: emailCtrl.text, password: passCtrl.text);
        if (jsonSignIn != false) {
          AppCache cache = AppCache();
          await cache.setString('token', jsonSignIn['token']);
          await cache.setString('email', jsonSignIn['user_email']);
          await cache.setString('name', jsonSignIn['user_display_name']);

        }
      }
      await Future<void>.delayed(const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInView(
      context: context,
      emailCtrl: emailCtrl,
      passCtrl: passCtrl,
      obscureText: obscureText,
      showPass: showPass,
      showPassFun: showPassFun,
      signInFun: signInFun,
      emailErrVis: emailErrVis,
      emailErrStr: emailErrStr,
      passErrVis: passErrVis,
      passErrStr: passErrStr,
      pageCtrl: widget.pageCtrl,
    );
  }
}
