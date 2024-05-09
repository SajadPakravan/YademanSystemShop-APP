
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: NestedScrollView(
//           floatHeaderSlivers: true,
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
//             appBar(),
//           ],
//           body: SingleChildScrollView(
//             child: jsonGetProductDetails.isEmpty
//                 ? Center(
//                     child: LoadingAnimationWidget.threeArchedCircle(
//                       color: Colors.black54,
//                       size: width * 0.1,
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       ProductImagesSlide(
//                         currentSlide: currentSlide,
//                         callback: callback,
//                         json: jsonGetProductDetails,
//                       ),
//                       productDetails(),
//                       productReviews(),
//                       relatedProducts(),
//                     ],
//                   ),
//           ),
//         ),
//         bottomNavigationBar: cartPrice(),
//       ),
//     );
//   }
//

//

//

//

//
//   relatedProducts() {
//     double width = MediaQuery.of(context).size.width;
//
//     if (listProductsDetail.isEmpty) {
//       return Container(
//         margin: EdgeInsets.all(width * 0.02),
//         child: LoadingAnimationWidget.threeArchedCircle(
//           color: Colors.black54,
//           size: width * 0.1,
//         ),
//       );
//     } else {
//       return Container(
//         padding: EdgeInsets.symmetric(vertical: width * 0.05),
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.black12,
//               width: 1,
//             ),
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.03),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "محصولات مشابه",
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: TextButton.icon(
//                         label: Text(
//                           "مشاهده همه",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.black87,
//                         ),
//                         onPressed: () {
//                           // homeViewModel.onPressAllCatProducts(
//                           //   categoryId: categoryId,
//                           // );
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: width * 0.7,
//               child: ListView.builder(
//                 itemCount: listProductsDetail.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   ProductModel productModel = listProductsDetail[index];
//                   Images productImage = listProductsImage[index];
//
//                   String? name = productModel.name;
//
//                   if (name!.isNotEmpty && name.length >= 40) {
//                     name = productModel.name!.replaceRange(40, productModel.name!.length, ' ... ');
//                   }
//
//                   TextDecoration textDecoration = TextDecoration.none;
//                   Color textColor = Colors.black87;
//                   bool visibleSalePrice = true;
//
//                   String? regularPrice = productModel.regularPrice.toString().toPersianDigit();
//                   String? salePrice = productModel.salePrice.toString().toPersianDigit();
//
//                   if (regularPrice.isNotEmpty) {
//                     regularPrice = regularPrice.seRagham();
//                   }
//
//                   int regularPrice2 = 0;
//                   int salePrice2 = 0;
//
//                   double percent = 0;
//                   String toman = "";
//                   int roundPercent = 0;
//
//                   regularPrice2 = int.parse(productModel.regularPrice.toString());
//
//                   if (productModel.salePrice!.isNotEmpty) {
//                     visibleSalePrice = true;
//                     textDecoration = TextDecoration.lineThrough;
//                     textColor = Colors.black38;
//                     fontSize = 12;
//
//                     salePrice = salePrice.seRagham();
//                     salePrice2 = int.parse(productModel.salePrice.toString());
//
//                     percent = (((regularPrice2 * 100) / salePrice2) - 100).roundToDouble();
//                     roundPercent = percent.toInt();
//                   } else {
//                     visibleSalePrice = false;
//                     textDecoration = TextDecoration.none;
//                     textColor = Colors.black87;
//                     fontSize = 14;
//                     toman = " تومان";
//                   }
//
//                   return InkWell(
//                     child: Container(
//                       width: width * 0.5,
//                       padding: EdgeInsets.symmetric(horizontal: width * 0.03),
//                       decoration: const BoxDecoration(
//                         border: Border(
//                           left: BorderSide(
//                             color: Colors.grey,
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.network(
//                             productImage.src.toString(),
//                             height: width * 0.35,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(
//                                 Icons.now_wallpaper_rounded,
//                                 size: width * 0.35,
//                                 color: Colors.black26,
//                               );
//                             },
//                           ),
//                           Container(
//                             alignment: Alignment.centerRight,
//                             margin: EdgeInsets.symmetric(vertical: width * 0.03),
//                             child: Text(
//                               name.toString(),
//                               textAlign: TextAlign.right,
//                               style: Theme.of(context).textTheme.bodyMedium,
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Visibility(
//                                   visible: visibleSalePrice,
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//                                     margin: EdgeInsets.only(left: width * 0.01),
//                                     decoration: BoxDecoration(
//                                       color: Colors.red.shade600,
//                                       borderRadius: BorderRadius.circular(width * 0.01),
//                                     ),
//                                     child: Text(
//                                       "${roundPercent.toString().toPersianDigit()}%",
//                                       textAlign: TextAlign.center,
//                                       style: Theme.of(context).textTheme.buttonText1,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     regularPrice + toman,
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: textColor,
//                                       fontFamily: appTexts.appFont,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: fontSize,
//                                       decoration: textDecoration,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Visibility(
//                             visible: visibleSalePrice,
//                             child: Container(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "$salePrice تومان",
//                                 textAlign: TextAlign.left,
//                                 style: Theme.of(context).textTheme.price,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     onTap: () {
//                       onTapProduct(productId: productModel.id!);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   cartPrice() {
//     TextDecoration textDecoration = TextDecoration.none;
//     Color textColor = Colors.black87;
//     double fontSize = 14;
//     bool visibleSalePrice = true;
//
//     double percent = 0;
//     String toman = "";
//     int roundPercent = 0;
//
//     if (salePrice.isNotEmpty) {
//       setState(() {
//         visibleSalePrice = true;
//         textDecoration = TextDecoration.lineThrough;
//         textColor = Colors.black38;
//         fontSize = 12;
//         percent = (((regularPrice2 * 100) / salePrice2) - 100).roundToDouble();
//         roundPercent = percent.toInt();
//         pPrice = salePrice2.toInt();
//       });
//     } else {
//       setState(() {
//         visibleSalePrice = false;
//         textDecoration = TextDecoration.none;
//         textColor = Colors.black87;
//         fontSize = 14;
//         toman = " تومان";
//         pPrice = regularPrice2.toInt();
//       });
//     }
//
//     double width = MediaQuery.of(context).size.width;
//
//     return AnimatedOpacity(
//       opacity: visible ? 1 : 0,
//       duration: const Duration(milliseconds: 500),
//       child: Container(
//         height: width * 0.18,
//         padding: EdgeInsets.symmetric(
//           horizontal: width * 0.04,
//           vertical: width * 0.03,
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           border: Border(
//             top: BorderSide(color: Colors.black12),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             progress
//                 ? const CircularProgressIndicator()
//                 : isAddCart
//                     ? existCart()
//                     : InkWell(
//                         child: Container(
//                           padding: EdgeInsets.all(width * 0.03),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade600,
//                             borderRadius: BorderRadius.circular(width * 0.02),
//                           ),
//                           child: Text(
//                             "افزودن به سبد خرید",
//                             style: Theme.of(context).textTheme.buttonText1,
//                           ),
//                         ),
//                         onTap: () {
//                           setState(() {
//                             isAddCart = true;
//                           });
//                         },
//                       ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Visibility(
//                         visible: visibleSalePrice,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//                           margin: EdgeInsets.only(left: width * 0.01),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade600,
//                             borderRadius: BorderRadius.circular(width * 0.01),
//                           ),
//                           child: Text(
//                             "${roundPercent.toString().toPersianDigit()}%",
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.buttonText1,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           regularPrice + toman,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: textColor,
//                             fontFamily: appTexts.appFont,
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSize,
//                             decoration: textDecoration,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Visibility(
//                   visible: visibleSalePrice,
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "$salePrice تومان",
//                       textAlign: TextAlign.left,
//                       style: Theme.of(context).textTheme.price,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   existCart() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Text(
//               "5",
//               style: Theme.of(context).textTheme.quantityProduct,
//             ),
//             Text(
//               " عدد در سبد خرید شما",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "مشاهده ",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             InkWell(
//               child: Text(
//                 "سبد خرید",
//                 style: Theme.of(context).textTheme.quantityProduct,
//               ),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   onTapProduct({required int productId}) async {
//     SharedPreferences sharePref = await SharedPreferences.getInstance();
//     sharePref.setInt("productId", productId);
//
//     setState(() {
//       jsonGetProductDetails = "";
//       jsonGetProductReviews = "";
//       listProductsReviews = [];
//       listProductsDetail = [];
//       listProductsImage = [];
//       favoriteIcon = Icons.favorite_outline;
//       favoriteIconColor = Colors.black54;
//       favorite = true;
//       isAddCart = false;
//       numLoad = 0;
//     });
//     loadContent();
//   }
//
// // addCart() async {
// //   setState(() {
// //     progress = true;
// //   });
// //   SharedPreferences sharePref = await SharedPreferences.getInstance();
// //   int productId = sharePref.getInt("productId")!;
// //
// //   int totalPrice = pPrice * quantity;
// //
// //   final cart = Cart(
// //     productId: productId,
// //     productImage: imageList[0],
// //     productName: name,
// //     productPrice: pPrice,
// //     productQuantity: quantity,
// //     productTotalPrice: totalPrice,
// //   );
// //
// //   await CartDatabase.instance.insert(cart);
// //   checkCartProduct();
// //   checkCart();
// // }
//
// // checkCart() async {
// //   List<Cart> cartList = await CartDatabase.instance.readAllCart();
// //   if (cartList.isNotEmpty) {
// //     setState(() {
// //       // MainScreenView.isCartEmpty = true;
// //     });
// //   } else {
// //     setState(() {
// //       // MainScreenView.isCartEmpty = false;
// //     });
// //   }
// // }
//
// // quantityView() {
// //   return Row(
// //     children: [
// //       IconButton(
// //         icon: Icon(Icons.add_circle, color: Colors.blue.shade600),
// //         onPressed: () {
// //           if (quantity < 50) {
// //             setState(() {
// //               quantity++;
// //             });
// //           }
// //         },
// //       ),
// //       Container(
// //           margin: EdgeInsets.symmetric(
// //               horizontal: MediaQuery.of(context).size.width * 0.02),
// //           child: Text(quantity.toString().toPersianDigit())),
// //       IconButton(
// //         icon: Icon(Icons.remove_circle, color: Colors.blue.shade600),
// //         onPressed: () {
// //           if (quantity > 1) {
// //             setState(() {
// //               quantity--;
// //             });
// //           }
// //         },
// //       ),
// //     ],
// //   );
// // }
//
// // checkCartProduct() async {
// //   setState(() {
// //     progress = true;
// //   });
// //
// //   SharedPreferences sharePref = await SharedPreferences.getInstance();
// //   int productId = sharePref.getInt("productId")!;
// //
// //   dynamic cart = await CartDatabase.instance.readCart(productId);
// //
// //   if (cart == false) {
// //     setState(() {
// //       isAddCart = false;
// //     });
// //   } else {
// //     setState(() {
// //       isAddCart = true;
// //     });
// //   }
// //
// //   setState(() {
// //     progress = false;
// //   });
// }
