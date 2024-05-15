import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/screens/main/main_screen.dart';
import 'package:yad_sys/tools/app_colors.dart';
import 'package:yad_sys/tools/app_print.dart';
import 'package:yad_sys/tools/app_texts.dart';
import 'package:yad_sys/tools/app_themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HttpRequest httpRequest = HttpRequest(context: Get.context!);
  bool opacity = false;
  AppColors appColors = AppColors();
  AppTexts appTexts = AppTexts();
  bool connectionStatus = true;
  bool confirm = false;
  bool internetStatus = true;
  bool tryAgain = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    checkConnection();
  }

  checkConnection() async {
    if (tryAgain) {
      setState(() {
        tryAgain = false;
      });

      internetStatus = await InternetConnectionChecker().hasConnection;
      log('Internet Status >>>> $internetStatus');

      if (internetStatus) {
        setState(() {
          connectionStatus = true;
          confirm = false;
        });
        urlCheckConnection();
      } else {
        setState(() {
          connectionStatus = false;
          confirm = false;
        });
      }
    } else {
      InternetConnectionChecker().onStatusChange.listen((status) async {
        internetStatus = status == InternetConnectionStatus.connected;

        if (internetStatus) {
          setState(() {
            connectionStatus = true;
            confirm = false;
          });
          urlCheckConnection();
        } else {
          setState(() {
            connectionStatus = false;
            confirm = false;
          });
        }
      });
    }
  }

  urlCheckConnection() async {
    try {
      await httpRequest.getProducts();
      setState(() {
        confirm = true;
      });
      Timer(
        const Duration(seconds: 2),
        () {
          Get.off(
            const MainScreen(),
            transition: Transition.fade,
            duration: const Duration(seconds: 1),
          );
        },
      );
    } catch (e) {
      log("Request ERROR >>>> $e");
      setState(() {
        connectionStatus = false;
        confirm = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appColors.blueFav,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: SimpleShadow(
              color: Colors.black,
              offset: const Offset(-25, 15),
              child: Image.asset(
                "assets/images/logos/application_logo.png",
                fit: BoxFit.contain,
                scale: width * 0.009,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomCenter,
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(
                  speed: const Duration(milliseconds: 100),
                  "Yademan System",
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontFamily: "harlow",
                    color: Colors.white,
                    fontSize: width * 0.08,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: connectionStatus
          ? Container(
              height: width * 0.25,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: width * 0.04),
              child: confirm
                  ? Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: width * 0.1,
                    )
                  : LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.white,
                      size: width * 0.1,
                    ),
            )
          : Container(
              height: width * 0.25,
              padding: EdgeInsets.only(bottom: width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText(
                    "مشکل در اتصال\n"
                    "لطفا فیلترشکن را خاموش کرده و وضعیت اینترنت را بررسی کنید",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.errorText1.copyWith(height: 1.5),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(top: width * 0.02),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tryAgain = true;
                        });
                        checkConnection();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.autorenew_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            "تلاش مجدد",
                            style: Theme.of(context).textTheme.errorText1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
