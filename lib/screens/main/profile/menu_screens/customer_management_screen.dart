import 'package:flutter/material.dart';


class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomerManagementScreenState createState() =>
      _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Config().backgroundColorPage,
      appBar: AppBar(),
    );
  }
}
