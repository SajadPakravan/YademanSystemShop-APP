import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/tools/app_colors.dart';
import 'package:yad_sys/tools/app_dimension.dart';
import 'package:yad_sys/tools/app_themes.dart';

class AppDialogs {
  AppColors appColors = AppColors();
  AppDimension appDimension = AppDimension();

  requestFalse({required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (ctx, a1, a2) {
        throw UnimplementedError();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.linear.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(width * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * 0.02),
                      topRight: Radius.circular(width * 0.02),
                    ),
                  ),
                  child: AutoSizeText(
                    "مشکل در دریافت اطلاعات",
                    style: Theme.of(context).textTheme.errorText1,
                    maxLines: 1,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      top: width * 0.05,
                      bottom: width * 0.02,
                      left: width * 0.02,
                      right: width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width * 0.02),
                        bottomRight: Radius.circular(width * 0.02),
                      ),
                    ),
                    child: Column(
                      children: [
                        AutoSizeText(
                          "برنامه نمی‌تواند اطلاعات را دریافت کند\n"
                          "در صورت روشن بودن فیلتر شکن، لطفا فیلترشکن را خاموش کرده و وضعیت اینترنت را بررسی کنید",
                          style: Theme.of(context).textTheme.errorText2,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: width * 0.08,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(appColors.blueFav),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "تلاش مجدد",
                                style: Theme.of(context).textTheme.buttonText1,
                              ),
                              const Icon(
                                Icons.autorenew_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: appDimension.dialogDuration),
    );
  }
}
