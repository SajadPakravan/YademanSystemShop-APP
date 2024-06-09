// import 'package:flutter/material.dart';
// import 'package:yad_sys/themes/color_style.dart';
// import 'package:yad_sys/widgets/date_picker_view.dart';
//
// ColorStyle colorStyle = ColorStyle();
//
// bottomSheetDatePicker({required BuildContext context, required Function(String) onTap}) {
//   String datePicker = "";
//   showModalBottomSheet(
//     backgroundColor: Theme.of(context).colorScheme.background,
//     context: context,
//     builder: (context) {
//       return Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             DatePickerView(onChange: (value) => datePicker = value),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 datePickerBtn(
//                   context: context,
//                   title: "ثبت تاریخ",
//                   color: ColorStyle.changer(
//                     context: context,
//                     lightColor: ColorStyle.colorPurple,
//                     darkColor: ColorStyle.colorPurpleDark,
//                   ),
//                   onPressed: () {
//                     onTap(datePicker);
//                     Navigator.pop(context);
//                   },
//                 ),
//                 datePickerBtn(
//                   context: context,
//                   title: "بستن",
//                   color: Colors.grey,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
//
// datePickerBtn({
//   required BuildContext context,
//   required String title,
//   required Color color,
//   required Function() onPressed,
// }) {
//   return Expanded(
//     flex: 2,
//     child: TextButton(
//       onPressed: onPressed,
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(horizontal: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: color,
//         ),
//         child: Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
//       ),
//     ),
//   );
// }
