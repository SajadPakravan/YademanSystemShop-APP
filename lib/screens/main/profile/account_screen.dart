import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/database/yademan_db.dart';
import 'package:yad_sys/models/user_model.dart';
import 'package:yad_sys/views/main_views/account_view.dart';
import 'package:yad_sys/widgets/app_dialogs.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with TickerProviderStateMixin {
  HttpRequest httpRequest = HttpRequest();
  User user = const User();
  final pageCtrl = PageController(initialPage: 0);
  AppDialogs appDialogs = AppDialogs();
  bool progress = false;
  bool logged = false;
  int userId = 0;
  String role = "";
  String name = "";
  String email = "";
  String avatar = "";
  int numberCart = 0;
  TextEditingController fieldEmail = TextEditingController();
  TextEditingController fieldPass = TextEditingController();
  bool obscureText = true;
  int selectedBtn = 0;
  double subAccHeight = 0;
  double subAddHeight = 0;

  onTapButton(index) {
    selectedBtn = index;
    print("index >>>> $index");
    subAccHeight = subStatus(0, subAccHeight);
    subAddHeight = subStatus(2, subAddHeight);
  }

  double subStatus(int index, double height) {
    if (selectedBtn == index) {
      print("selectedBtn >>>> $selectedBtn");
      if (height == 0) {
        return 0.18;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  logOut() async {
    await YadSysDB.instance.deleteAll();
    checkLogged();
  }

  checkLogged() async {
    dynamic user = await YadSysDB.instance.getUser();
    if (user == false) {
      setState(() {
        logged = false;
      });
    } else {
      setState(() {
        logged = true;
        name = user.name!;
        email = user.email!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkLogged();
    return AccountView(
      context: context,
      logged: logged,
      name: name,
      email: email,
      logOut: logOut,
      pageCtrl: pageCtrl,
      onTapButton: onTapButton,
      subAccHeight: subAccHeight,
      subAddHeight: subAddHeight,
    );
  }
}
