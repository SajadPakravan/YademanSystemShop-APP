import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/database/cart_model.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/screens/main/profile/address/address_screen.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/tools/to_page.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class ContinuePaymentScreen extends StatefulWidget {
  const ContinuePaymentScreen({super.key, required this.cartBox});

  final Box<CartModel> cartBox;

  @override
  State<ContinuePaymentScreen> createState() => _ContinuePaymentScreenState();
}

class _ContinuePaymentScreenState extends State<ContinuePaymentScreen> {
  HttpRequest httpRequest = HttpRequest();
  AppCache cache = AppCache();
  CustomerModel customer = CustomerModel();
  bool loading = false;
  bool addressAlert = false;
  int totalCart = 0;
  int shippingTotal = 0;
  int totalPrice = 0;

  getCustomer() async {
    setState(() => loading = true);
    dynamic jsonCustomer = await httpRequest.getCustomer(email: await cache.getString('email'));
    jsonCustomer.forEach((c) => setState(() => customer = CustomerModel.fromJson(c)));
    if (customer.billing!.city!.isEmpty) setState(() => addressAlert = true);
    setState(() => loading = false);
  }

  increaseQuantity(int id) {
    final cart = widget.cartBox.values.firstWhere((element) => element.id == id);
    cart.quantity++;
    cart.save();
    setState(() {});
    setDetailPrice();
  }

  decreaseQuantity(int id) {
    final cart = widget.cartBox.values.firstWhere((element) => element.id == id);
    if (cart.quantity > 1) {
      cart.quantity--;
      cart.save();
    }
    setState(() {});
    setDetailPrice();
  }

  setDetailPrice() {
    totalCart = 0;
    shippingTotal = 0;
    for (int i = 0; i < widget.cartBox.length; i++) {
      CartModel cart = widget.cartBox.getAt(i)!;
      setShippingTotal(cart);
      setState(() {
        totalCart += cart.price * cart.quantity;
        totalPrice = totalCart + shippingTotal;
      });
    }
  }

  setShippingTotal(CartModel cart) {
    int shPrice = 0;
    switch (cart.shippingClass) {
      case 'small':
        {
          shPrice = 50000;
          break;
        }
      case 'medium':
        {
          shPrice = 70000;
          break;
        }
      case 'big':
        {
          shPrice = 90000;
          break;
        }
    }
    shPrice *= cart.quantity;
    setState(() => shippingTotal += shPrice);
  }

  @override
  void initState() {
    super.initState();
    getCustomer();
    setDetailPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppBarView(title: 'تاید آدرس و فاکتور'),
        body: loading
            ? const Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextBodyMediumView('ارسال به', color: Colors.grey.shade700),
                        ),
                        subtitle: addressAlert
                            ? const TextBodyMediumView('لطفاآدرس را در صفحه پروفایل تکمیل کنید')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBodyMediumView(
                                    '${customer.shipping!.state!}، ${customer.shipping!.city!}، ${customer.shipping!.address1!}، ${customer.shipping!.address2!}',
                                    height: 2,
                                  ),
                                  TextBodyMediumView(customer.shipping!.postcode!.toString().toPersianDigit(), height: 2),
                                  TextBodyMediumView('${customer.shipping!.firstName!} ${customer.shipping!.lastName!}'),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: TextButton.icon(
                                        label: const TextBodyMediumView('تغییر آدرس و مشخصات', color: Colors.indigo),
                                        icon: const Icon(Icons.keyboard_arrow_left),
                                        onPressed: () async {
                                          await toPage(const AddressScreen(), arguments: customer);
                                          getCustomer();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                          child: TextBodyMediumView(
                            '${widget.cartBox.length.toString().toPersianDigit()} عدد کالا در سبد خرید شما',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.23,
                          child: ValueListenableBuilder(
                            valueListenable: widget.cartBox.listenable(),
                            builder: (context, Box<CartModel> box, _) {
                              return ListView.builder(
                                itemCount: box.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  CartModel cart = box.getAt(index)!;
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(child: CachedNetworkImage(imageUrl: cart.image, fit: BoxFit.contain)),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.add_circle, color: Colors.indigo, size: 30),
                                                onPressed: () => increaseQuantity(cart.id),
                                              ),
                                              const SizedBox(width: 10),
                                              TextBodyMediumView(cart.quantity.toString().toPersianDigit(), fontSize: 18),
                                              const SizedBox(width: 10),
                                              IconButton(
                                                icon: const Icon(Icons.remove_circle, color: Colors.indigo, size: 30),
                                                onPressed: cart.quantity == 1 ? null : () => decreaseQuantity(cart.id),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: index + 1 != widget.cartBox.length,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.26,
                                              width: 1,
                                              decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black38))),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: TextBodyLargeView('جزئیات قیمت', fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextBodyMediumView('جمع کل سبد خرید'),
                                TextBodyMediumView(
                                  '${totalCart.toString().toPersianDigit().seRagham()} تومان',
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextBodyMediumView('هزینه ارسال'),
                                TextBodyMediumView(
                                  '${shippingTotal.toString().toPersianDigit().seRagham()} تومان',
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextBodyMediumView('مبلغ قابل پرداخت'),
                                TextBodyMediumView(
                                  '${totalPrice.toString().toPersianDigit().seRagham()} تومان',
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
