// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:persian_number_utility/src/extensions.dart';
// import 'package:yademan_system_shop/connections/http_request.dart';
// import 'package:yademan_system_shop/database/cart_database.dart';
// import 'package:yademan_system_shop/models/cart_model.dart';
// import 'package:yademan_system_shop/views/main_screen.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   HttpRequest httpRequest = HttpRequest();
//   List<Cart> cartList = [];
//   bool progress = false;
//   int total = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     readAllCart();
//   }
//
//   readAllCart() async {
//     setState(() {
//       total = 0;
//     });
//
//     cartList = await CartDatabase.instance.readAllCart();
//     setState(() {
//       cartList = cartList;
//     });
//
//     if (cartList.isEmpty) {
//       setState(() {
//         // MainScreenView.isCartEmpty = false;
//       });
//     }
//
//     for (int i = 0; i < cartList.length; i++) {
//       Cart cart = cartList[i];
//       setState(() {
//         total += cart.productTotalPrice!.toInt();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         // backgroundColor: Config().backgroundColorPage,
//         appBar: AppBar(
//           title: const Text("سبد خرید"),
//           centerTitle: true,
//         ),
//         body: cartList.isEmpty
//             ? const Center(
//                 child: Text(
//                   "هیچ محصولی به سبد خرید خود اضافه نکردید",
//                 ),
//               )
//             : Column(
//                 children: [
//                   cartListView(_width, _height),
//                   totalPrice(),
//                 ],
//               ),
//       ),
//     );
//   }
//
//   totalPrice() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
//       margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           progress
//               ? const CircularProgressIndicator()
//               : ElevatedButton(
//                   child: const Text("سفارش دهید"),
//                   onPressed: () {
//                     addOrders();
//                   },
//                 ),
//           Text(
//             total.toString().toPersianDigit().seRagham() + " تومان",
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.width * 0.04,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   addOrders() async {
//     setState(() {
//       progress = true;
//     });
//
//     List<Map<String, int>> line_items = [];
//
//     for (int i = 0; i < cartList.length; i++) {
//       Cart cart = cartList[i];
//
//       Map<String, int> items = {
//         "product_id": cart.productId!.toInt(),
//         "quantity": cart.productQuantity!.toInt()
//       };
//       line_items.add(items);
//     }
//
//     dynamic jsonCreateOrder = await httpRequest.createOrder(
//       status: 'completed',
//       line_items: line_items,
//     );
//     print(jsonCreateOrder);
//
//     if (jsonCreateOrder == false) {
//       final snackBar = SnackBar(
//         backgroundColor: Colors.red.shade700,
//         content: const Text(
//           'خطا در ثبت سفارش',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//       setState(() {
//         progress = false;
//       });
//     } else {
//       setState(() {
//         progress = false;
//       });
//
//       await CartDatabase.instance.deleteAll();
//       readAllCart();
//
//       final snackBar = SnackBar(
//         backgroundColor: Colors.green.shade700,
//         content: const Text(
//           'سفارش شما تکمیل شد',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }
//
//   cartListView(double _width, double _height) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: cartList.length,
//         itemBuilder: (BuildContext context, int index) {
//           Cart cart = cartList[index];
//
//           String productName = cart.productName.toString();
//           if (productName.isNotEmpty && productName.length >= 30) {
//             productName =
//                 productName.replaceRange(30, productName.length, ' ... ');
//           }
//
//           int productPrice = cart.productPrice!.toInt();
//           int productQuantity = cart.productQuantity!.toInt();
//           int productTotalPrice = cart.productTotalPrice!.toInt();
//
//           return Container(
//             margin: EdgeInsets.symmetric(
//               vertical: _height * 0.02,
//               horizontal: _width * 0.02,
//             ),
//             padding: EdgeInsets.all(_width * 0.02),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: _width * 0.03),
//                       child: Image.network(
//                         cart.productImage.toString(),
//                         width: _width * 0.3,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Text(productName),
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                             vertical: _height * 0.02,
//                           ),
//                           child: Text(productPrice
//                                   .toString()
//                                   .toPersianDigit()
//                                   .seRagham() +
//                               " تومان"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 bottomCart(
//                   _width,
//                   _height,
//                   cart,
//                   productPrice,
//                   productQuantity,
//                   productTotalPrice,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   deleteCart(Cart cart) async {
//     await CartDatabase.instance.delete(cart.id!);
//     readAllCart();
//   }
//
//   bottomCart(
//     double _width,
//     double _height,
//     Cart cart,
//     int productPrice,
//     int productQuantity,
//     int productTotalPrice,
//   ) {
//     return Container(
//       margin: EdgeInsets.only(
//         top: _height * 0.02,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade700,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.close),
//             color: Colors.white,
//             onPressed: () {
//               deleteCart(cart);
//             },
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(
//               horizontal: _width * 0.02,
//             ),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.add_circle, color: Colors.white),
//                   onPressed: () {
//                     increaseOrDecreaseNumberOrder(
//                       true,
//                       cart,
//                       productPrice,
//                       productQuantity,
//                       productTotalPrice,
//                     );
//                   },
//                 ),
//                 Text(
//                   productQuantity.toString().toPersianDigit() + " عدد",
//                   style: const TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.remove_circle, color: Colors.white),
//                   onPressed: () {
//                     increaseOrDecreaseNumberOrder(
//                       false,
//                       cart,
//                       productPrice,
//                       productQuantity,
//                       productTotalPrice,
//                     );
//                   },
//                 ),
//                 Text(
//                   productTotalPrice.toString().toPersianDigit().seRagham() +
//                       " تومان",
//                   style: const TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   increaseOrDecreaseNumberOrder(
//     bool increase,
//     Cart cart,
//     int productPrice,
//     int productQuantity,
//     int productTotalPrice,
//   ) async {
//     if (increase && productQuantity < 50) {
//       productQuantity++;
//     } else if (increase == false && productQuantity > 1) {
//       productQuantity--;
//     }
//
//     if (productQuantity != cart.productQuantity) {
//       productTotalPrice = productPrice * productQuantity;
//
//       await CartDatabase.instance.update(cart.copy(
//         productQuantity: productQuantity,
//         productTotalPrice: productTotalPrice,
//       ));
//       readAllCart();
//     }
//   }
// }
