import 'package:flutter/material.dart';


class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Config().backgroundColorPage,
      appBar: AppBar(),
    );
  }
}
