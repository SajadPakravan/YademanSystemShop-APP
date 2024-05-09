//
// import 'package:flutter/material.dart';
// import 'package:yademan_system_shop/views/addresses_screens/bill_address_screen.dart';
// import 'package:yademan_system_shop/views/addresses_screens/shipping_address_screen.dart';
//
// class AddressScreen extends StatefulWidget {
//   const AddressScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         // backgroundColor: Config().backgroundColorPage,
//         appBar: AppBar(
//           title: const Text("ویرایش آدرس"),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   address_card("آدرس صورت حساب", "bill_address"),
//                   address_card("آدرس حمل و نقل", "shipping_address"),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   address_card(String title, String screen) {
//     return InkWell(
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.only(bottom: 20),
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: Colors.grey,
//               width: 2,
//             )),
//         child: Text(title),
//       ),
//       onTap: () {
//         switch (screen) {
//           case "bill_address":
//             {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const BillAddressScreen()));
//               break;
//             }
//           case "shipping_address":
//             {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ShippingAddressScreen()));
//               break;
//             }
//         }
//       },
//     );
//   }
// }
