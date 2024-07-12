import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yad_sys/database/cart_model.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Box<CartModel> cartBox = Hive.box<CartModel>('cartBox');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
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
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(imageUrl: cart.image, fit: BoxFit.contain),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBodyMediumView(cart.name, fontWeight: FontWeight.bold, textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                          TextBodyMediumView('${cart.price} تومان', fontWeight: FontWeight.bold),
                          const SizedBox(height: 20),
                          IntrinsicWidth(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(border: Border.all(color: Colors.black45), borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const TextBodyMediumView('+', fontSize: 30, color: Colors.red),
                                  const SizedBox(width: 20),
                                  TextBodyMediumView(cart.quantity.toString(), fontSize: 18),
                                  const SizedBox(width: 20),
                                  cart.quantity == 1
                                      ? const Icon(Icons.delete, color: Colors.red)
                                      : const TextBodyMediumView('-', fontSize: 30, color: Colors.red),
                                ],
                              ),
                            ),
                          ),
                        ],
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
