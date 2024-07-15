// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yademan_system_shop/views/main_screens/profile_view.dart';
//
// class SettingsScreenView extends StatefulWidget {
//   const SettingsScreenView({Key? key}) : super(key: key);
//
//   @override
//   State<SettingsScreenView> createState() => _SettingsScreenViewState();
// }
//
// class _SettingsScreenViewState extends State<SettingsScreenView> {
//   bool statusLogin = false;
//
//   logout() async {
//     SharedPreferences sharePref = await SharedPreferences.getInstance();
//     sharePref.clear();
//     setState(() {
//       statusLogin = false;
//       sharePref.setBool("statusLogin", statusLogin);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(),
//         body: TextButton(
//           child: Text(
//             "خروج از حساب",
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           onPressed: () {
//             logout();
//             Get.back(result: statusLogin);
//           },
//         ),
//       ),
//     );
//   }
// }
