import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/screens/main_screen.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextBodyLargeView(
                "مشکل در اتصال\n"
                "لطفا فیلترشکن را خاموش کرده و وضعیت اینترنت را بررسی کنید",
                color: Colors.white,
                height: 1.7,
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.offAll(const MainScreen());
                    },
                    splashColor: Colors.white.withOpacity(0.2),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.autorenew_rounded, color: Colors.white),
                          SizedBox(width: 5),
                          Flexible(
                            child: TextBodyLargeView(
                              'اجرای مجدد برنامه',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
