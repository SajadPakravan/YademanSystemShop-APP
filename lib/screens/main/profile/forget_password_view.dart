// import 'package:flutter/material.dart';
//
// class ForgetPassword extends StatefulWidget {
//   const ForgetPassword({Key? key}) : super(key: key);
//
//   @override
//   _ForgetPasswordState createState() => _ForgetPasswordState();
// }
//
// class _ForgetPasswordState extends State<ForgetPassword> {
//   @override
//   Widget build(BuildContext context) {
//     var _width = MediaQuery.of(context).size.width;
//     var _height = MediaQuery.of(context).size.height;
//
//     return SafeArea(
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           body: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 30),
//                 child: const Text(
//                   "کلمه عبور را فراموش کرده اید؟",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Form(
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         decoration: InputDecoration(
//                           hintText: "نام کاربری",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(vertical: 20),
//                         child: TextFormField(
//                           keyboardType: TextInputType.visiblePassword,
//                           decoration: InputDecoration(
//                             hintText: "کلمه عبور",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           child: const Text(
//                             "کلمه عبور را فراموش کرده ام",
//                             textAlign: TextAlign.center,
//                           ),
//                           onPressed: () => Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                               const ForgetPassword(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.center,
//                         child: MaterialButton(
//                           child: const Text(
//                             "ورود",
//                             textAlign: TextAlign.center,
//                           ),
//                           onPressed: () => Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                               const ForgetPassword(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
