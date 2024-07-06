import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/views/account_views/sign_up_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.pageCtrl});

  final PageController pageCtrl;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  HttpRequest httpRequest = HttpRequest();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController rePassCtrl = TextEditingController();
  bool obscureText = true;
  bool showPass = false;
  bool emailErrVis = false;
  String emailErrStr = "";
  bool passErrVis = false;
  String passErrStr = "";
  bool rePassErrVis = false;
  String rePassErrStr = "";

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

  signUpFun() async {
    setState(() {
      emailErrVis = false;
      passErrVis = false;
      rePassErrVis = false;
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

    if (rePassCtrl.text.isEmpty) {
      setState(() {
        rePassErrVis = true;
        rePassErrStr = 'لطفا تکرار کلمه عبور را وارد کنید';
      });
    } else if (rePassCtrl.text != passCtrl.text) {
      setState(() {
        rePassErrVis = true;
        rePassErrStr = 'تکرار کلمه عبور با کلمه عبور برابر نیست';
      });
    }

    if (!emailErrVis && !passErrVis && !rePassErrVis) {
      await Future<void>.delayed(const Duration(seconds: 3));
      // dynamic jsonSignUp = await httpRequest.signUp(email: emailCtrl.text, password: passCtrl.text);

      // if (jsonSignUp != false) {
      //   dynamic jsonSignIn = await httpRequest.signIn(email: emailCtrl.text, password: passCtrl.text);
      //   await YadSysDB.instance.insert(User(
      //     token: jsonSignIn['token'],
      //     name: jsonSignIn['user_display_name'],
      //     email: jsonSignIn['user_email'],
      //   ));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignUpView(
      context: context,
      emailCtrl: emailCtrl,
      passCtrl: passCtrl,
      rePassCtrl: rePassCtrl,
      obscureText: obscureText,
      showPass: showPass,
      showPassFun: showPassFun,
      signUpFun: signUpFun,
      emailErrVis: emailErrVis,
      emailErrStr: emailErrStr,
      passErrVis: passErrVis,
      passErrStr: passErrStr,
      rePassErrVis: rePassErrVis,
      rePassErrStr: rePassErrStr,
      pageCtrl: widget.pageCtrl,
    );
  }
}
