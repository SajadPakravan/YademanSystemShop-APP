import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/database/cart_model.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Box<CartModel> cartBox = Hive.box<CartModel>('cartBox');

  // increaseQuantity(int index) {
  //   CartModel cart = cartBox.getAt(index)!;
  //   cartBox.putAt(index, cart..quantity);
  //   setState(() {});
  // }
  //
  // decreaseQuantity(int index) {
  //   final cart = cartBox.getAt(index)!;
  //   if (cart.quantity > 1) cartBox.putAt(index, cart..quantity--);
  //   setState(() {});
  // }
  //
  // deleteItem(int index) {
  //   cartBox.deleteAt(index);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppBarView(title: 'سبد خرید'),
        body: ValueListenableBuilder(
          valueListenable: cartBox.listenable(),
          builder: (context, Box<CartModel> box, _) {
            if (box.isEmpty) return const Center(child: TextBodyMediumView('سبد خرید شما خالی است'));
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                CartModel cart = box.getAt(index)!;
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Flexible(flex: 1, child: CachedNetworkImage(imageUrl: cart.image, fit: BoxFit.contain)),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBodyMediumView(cart.name, fontWeight: FontWeight.bold, textAlign: TextAlign.center, maxLines: 1),
                              const SizedBox(height: 10),
                              TextBodyMediumView('${cart.price.toString().toPersianDigit().seRagham()} تومان', fontWeight: FontWeight.bold),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: IntrinsicWidth(
                                  child: Container(
                                    decoration:
                                    BoxDecoration(border: Border.all(color: Colors.black45), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.add_circle, color: Colors.indigo, size: 30),
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 20),
                                        TextBodyMediumView(cart.quantity.toString().toPersianDigit(), fontSize: 18),
                                        const SizedBox(width: 20),
                                        cart.quantity == 1
                                            ? IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.indigo, size: 30),
                                          onPressed: () {},
                                        )
                                            : IconButton(
                                          icon: const Icon(Icons.remove_circle, color: Colors.indigo, size: 30),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
