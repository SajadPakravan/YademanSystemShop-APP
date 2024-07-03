import 'package:flutter/material.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductManagementScreenState createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Config().backgroundColorPage,
      appBar: AppBar(),
    );
  }
}
