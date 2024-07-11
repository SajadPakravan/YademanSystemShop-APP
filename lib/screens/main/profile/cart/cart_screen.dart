import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yad_sys/database/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Box<CartModel> cartBox = Hive.box<CartModel>('cartBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, Box<CartModel> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              CartModel cart = box.getAt(index)!;
              return ListTile(
                leading: Image.network(cart.image),
                title: Text(cart.name),
                subtitle: Text('\$${cart.price}'),
                trailing: Text('Quantity: ${cart.quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}
