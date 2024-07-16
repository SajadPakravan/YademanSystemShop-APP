import 'package:flutter/material.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(title: 'سفارشات'),
    );
  }
}
