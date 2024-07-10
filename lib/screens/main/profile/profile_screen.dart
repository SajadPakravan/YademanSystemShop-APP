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
  AppCache cache = AppCache();
  CustomerModel customer = CustomerModel();
  PageController pageCtrl = PageController(initialPage: 0);
  bool logged = false;
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
    String email = await cache.getString('email') ?? '';
    if (email.isNotEmpty) {
      getCustomer();
    } else {
      setState(() {
        logged = false;
        loading = false;
      });
    }
  }

  getCustomer() async {
    setState(() => loading = true);
    dynamic jsonCustomer = await httpRequest.getCustomer(email: await cache.getString('email'));
    jsonCustomer.forEach((c) => setState(() => customer = CustomerModel.fromJson(c)));
    setState(() {
      personalInfoAlert = false;
      addressAlert = false;
    });
    if (customer.firstname!.isEmpty) setState(() => personalInfoAlert = true);
    if (customer.billing!.city!.isEmpty) setState(() => addressAlert = true);
    setState(() {
      logged = true;
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
      customer: customer,
      getCustomer: getCustomer,
      logged: logged,
      signOut: signOut,
      pageCtrl: pageCtrl,
      checkLogged: checkLogged,
      loading: loading,
      personalInfoAlert: personalInfoAlert,
      addressAlert: addressAlert,
    );
  }
}
