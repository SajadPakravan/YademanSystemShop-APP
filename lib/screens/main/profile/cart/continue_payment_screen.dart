import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class ContinuePaymentScreen extends StatefulWidget {
  const ContinuePaymentScreen({super.key});

  @override
  State<ContinuePaymentScreen> createState() => _ContinuePaymentScreenState();
}

class _ContinuePaymentScreenState extends State<ContinuePaymentScreen> {
  HttpRequest httpRequest = HttpRequest();
  AppCache cache = AppCache();
  CustomerModel customer = CustomerModel();
  bool loading = false;
  bool addressAlert = false;

  getCustomer() async {
    setState(() => loading = true);
    dynamic jsonCustomer = await httpRequest.getCustomer(email: await cache.getString('email'));
    jsonCustomer.forEach((c) => setState(() => customer = CustomerModel.fromJson(c)));
    if (customer.billing!.city!.isEmpty) setState(() => addressAlert = true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppBarView(title: 'ثبت سفارش'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const TextBodyLargeView('مشخصات گیرنده'),
                subtitle: addressAlert
                    ? const TextBodyMediumView('لطفا مشخصات گیرنده را در صفحه پروفایل تکمیل کنید')
                    : Column(
                        children: [
                          Row(
                            children: [
                              TextBodyMediumView('نام'),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
