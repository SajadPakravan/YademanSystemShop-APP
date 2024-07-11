import 'package:get/get.dart';

toPage(dynamic page, dynamic arguments) {
  return Get.to(page, transition: Transition.rightToLeft, duration: const Duration(milliseconds: 300), arguments: arguments);
}
