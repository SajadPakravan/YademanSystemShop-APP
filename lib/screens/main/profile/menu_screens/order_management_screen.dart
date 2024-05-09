import 'package:flutter/material.dart';


class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Config().backgroundColorPage,
      appBar: AppBar(),
    );
  }
}
