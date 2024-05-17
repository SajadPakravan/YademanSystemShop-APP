import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/screens/main/main_screen.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_themes.dart';

class ConnectionError extends StatefulWidget {
  const ConnectionError({super.key});

  @override
  State<ConnectionError> createState() => _ConnectionErrorState();
}

class _ConnectionErrorState extends State<ConnectionError> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorStyle.blueFav,
      body: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              "مشکل در اتصال\n"
                  "لطفا فیلترشکن را خاموش کرده و وضعیت اینترنت را بررسی کنید",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.errorText1,
            ),
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
                  Get.off(const MainScreen());
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
