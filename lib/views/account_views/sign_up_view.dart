import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yad_sys/tools/app_colors.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/tools/app_themes.dart';

// ignore: must_be_immutable
class SignUpView extends StatelessWidget {
  SignUpView({
    required this.context,
    required this.emailCtrl,
    required this.passCtrl,
    required this.rePassCtrl,
    required this.obscureText,
    required this.emailErrVis,
    required this.emailErrStr,
    required this.passErrVis,
    required this.passErrStr,
    required this.rePassErrVis,
    required this.rePassErrStr,
    required this.showPass,
    required this.showPassFun,
    required this.signUpFun,
    required this.pageCtrl,
    super.key,
  });

  BuildContext context;
  AppColors appColors = AppColors();
  AppTexts appTexts = AppTexts();
  TextEditingController emailCtrl;
  TextEditingController passCtrl;
  TextEditingController rePassCtrl;
  bool emailErrVis;
  String emailErrStr;
  bool passErrVis;
  String passErrStr;
  bool rePassErrVis;
  String rePassErrStr;
  PageController pageCtrl;
  bool obscureText = false;
  bool showPass = false;
  Function showPassFun;
  Function signUpFun;
  TextInputType keyboardType = TextInputType.emailAddress;
  IconData icon = Icons.email_rounded;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                textFormField(
                  controller: emailCtrl,
                  hint: "ایمیل",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  errorVis: emailErrVis,
                  errorStr: emailErrStr,
                ),
                textFormField(
                  controller: passCtrl,
                  hint: "گذرواژه",
                  icon: Icons.lock,
                  obscureText: obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  errorVis: passErrVis,
                  errorStr: passErrStr,
                ),
                textFormField(
                  controller: rePassCtrl,
                  hint: "تکرار گذرواژه",
                  icon: Icons.lock,
                  obscureText: obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  errorVis: rePassErrVis,
                  errorStr: rePassErrStr,
                ),
                Container(
                  width: width,
                  margin: const EdgeInsets.only(bottom: 50),
                  child: CheckboxMenuButton(
                    value: showPass,
                    onChanged: (v) {
                      showPassFun(v);
                    },
                    child: Text("نمایش گذرواژه", style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: EasyButton(
                    idleStateWidget: Text("ثبت‌نام", style: Theme.of(context).textTheme.buttonText1),
                    loadingStateWidget: Padding(
                      padding: const EdgeInsets.all(10),
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.white,
                        size: width * 0.1,
                      ),
                    ),
                    buttonColor: appColors.blueFav,
                    width: width,
                    height: 50,
                    borderRadius: width,
                    onPressed: signUpFun,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "قبلا ثبت‌نام کردید؟",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      child: Text(
                        "وارد شوید",
                        style: Theme.of(context).textTheme.txtBtnBlue,
                      ),
                      onTap: () {
                        pageCtrl.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFormField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    required TextInputType keyboardType,
    required bool errorVis,
    required String errorStr,
  }) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            obscuringCharacter: "*",
            style: Theme.of(context).textTheme.textField,
            // inputFormatters: [],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.hintText,
              hintTextDirection: TextDirection.rtl,
              prefixIcon: Icon(icon),
              fillColor: const Color.fromRGBO(223, 228, 234, 1.0),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(width)),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(width)),
                borderSide: BorderSide(
                  color: appColors.blueFav,
                  width: 2,
                ),
              ),
            ),
          ),
          Visibility(
            visible: errorVis,
            child: Text(errorStr, style: Theme.of(context).textTheme.errorText3),
          ),
        ],
      ),
    );
  }
}
