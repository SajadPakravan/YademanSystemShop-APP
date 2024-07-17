import 'package:flutter/material.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/order_model.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  HttpRequest httpRequest = HttpRequest();
  List<OrderModel> ordersLst = [];
  bool loading = false;

  getOrders() async {
    setState(() => loading = true);
    dynamic jsonOrders = await httpRequest.getOrders();
    jsonOrders.forEach((o) => setState(() => ordersLst.add(OrderModel.fromJson(o))));
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppBarView(title: 'سفارشات'),
        body: loading
            ? const Loading()
            : ordersLst.isEmpty
                ? const Center(child: TextBodyMediumView('شما هنوز سفارشی ثبت نکردید'))
                : ListView.builder(
                    itemCount: ordersLst.length,
                    itemBuilder: (context, index) {
                      OrderModel order = ordersLst[index];
                      LineItems item = order.lineItems![0];
                      return TextBodyMediumView(item.name! + order.id.toString());
                    },
                  ),
      ),
    );
  }
}
