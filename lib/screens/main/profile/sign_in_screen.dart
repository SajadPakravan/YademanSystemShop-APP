import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/database/yademan_db.dart';
import 'package:yad_sys/models/user_model.dart';
import 'package:yad_sys/views/account_views/sign_in_view.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  SignInScreen({
    required this.pageCtrl,
    super.key,
  });

  PageController pageCtrl;

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
      emailCtrl.text = emailCtrl.text.replaceAll(" ", "");
      passCtrl.text = passCtrl.text.replaceAll(" ", "");
      emailErrVis = false;
      passErrVis = false;
    });

    if (emailCtrl.text.isEmpty) {
      setState(() {
        emailErrVis = true;
        emailErrStr = "لطفا ایمل را وارد کنید";
      });
    } else {
      if (!EmailValidator.validate(emailCtrl.text, true)) {
        setState(() {
          emailErrVis = true;
          emailErrStr = "ایمیل وارد شده معتبر نیست";
        });
      }
    }

    if (passCtrl.text.isEmpty) {
      setState(() {
        passErrVis = true;
        passErrStr = "لطفا گذرواژه را وارد کنید";
      });
    }

    if (!emailErrVis && !passErrVis) {
      await Future<void>.delayed(const Duration(seconds: 3));
      dynamic jsonSignIn = await httpRequest.signIn(email: emailCtrl.text, password: passCtrl.text);

      if (jsonSignIn != false) {
        await YadSysDB.instance.insert(User(
          token: jsonSignIn['token'],
          name: jsonSignIn['user_display_name'],
          email: jsonSignIn['user_email'],
        ));
      }
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
