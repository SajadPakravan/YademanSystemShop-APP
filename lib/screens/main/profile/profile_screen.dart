import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/views/profile/profile_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  HttpRequest httpRequest = HttpRequest();
  PageController pageCtrl = PageController(initialPage: 0);
  bool logged = false;
  int userId = 0;
  String name = '';
  String email = '';
  String avatar = '';

  logOut() async {
    AppCache cache = AppCache();
    await cache.clearCache();
    checkLogged();
  }

  checkLogged() async {
    AppCache cache = AppCache();
    String n = await cache.getString('name') ?? '';
    String e = await cache.getString('email') ?? '';
    setState(() {
      name = n;
      email = e;
      logged = false;
    });
    if (name.isNotEmpty) setState(() => logged = true);
  }

  @override
  void initState() {
    super.initState();
    checkLogged();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(
      context: context,
      logged: logged,
      name: name,
      email: email,
      logOut: logOut,
      pageCtrl: pageCtrl,
      checkLogged: checkLogged,
    );
  }
}
