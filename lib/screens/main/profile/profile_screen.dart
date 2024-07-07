import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/views/profile/profile_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  HttpRequest httpRequest = HttpRequest();
  CustomerModel customer = CustomerModel();
  PageController pageCtrl = PageController(initialPage: 0);
  bool logged = false;
  int userId = 0;
  String name = '';
  String email = '';
  String avatar = '';
  bool loading = false;
  bool personalInfoAlert = false;
  bool addressAlert = false;

  signOut() async {
    AppCache cache = AppCache();
    await cache.clearCache();
    checkLogged();
  }

  checkLogged() async {
    setState(() => loading = true);
    AppCache cache = AppCache();
    String e = await cache.getString('email') ?? '';
    setState(() {
      email = e;
      logged = false;
    });
    if (email.isNotEmpty) {
      getCustomer();
      setState(() => logged = true);
    } else {
      setState(() => loading = false);
    }
  }

  getCustomer() async {
    AppCache cache = AppCache();
    dynamic jsonCustomer = await httpRequest.getCustomer(email: email);
    jsonCustomer.forEach((c) => setState(() => customer = CustomerModel.fromJson(c)));

    if (customer.firstName!.isEmpty) {
      setState(() => personalInfoAlert = true);
    } else {
      await cache.setString('name', '${customer.firstName!} ${customer.lastName}');
    }

    if (customer.billing!.city!.isEmpty) {
      setState(() => addressAlert = true);
    }
    setState(() {
      avatar = customer.avatarUrl!;
      loading = false;
    });
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
      avatar: avatar,
      signOut: signOut,
      pageCtrl: pageCtrl,
      checkLogged: checkLogged,
      loading: loading,
      personalInfoAlert: personalInfoAlert,
      addressAlert: addressAlert,
    );
  }
}
