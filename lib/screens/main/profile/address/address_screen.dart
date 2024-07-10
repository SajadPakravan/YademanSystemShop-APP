import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/app_dialogs.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/snack_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  HttpRequest httpRequest = HttpRequest();
  CustomerModel customer = CustomerModel();
  AppDialogs appDialogs = AppDialogs();
  String firstname = '';
  String lastname = '';
  String email = '';
  String phone = '';
  String company = '';
  String state = '';
  String city = '';
  String street = '';
  String number = '';
  String postcode = '';
  TextEditingController firstnameField = TextEditingController();
  TextEditingController lastnameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController companyField = TextEditingController();
  TextEditingController stateField = TextEditingController();
  TextEditingController cityField = TextEditingController();
  TextEditingController streetField = TextEditingController();
  TextEditingController numberField = TextEditingController();
  TextEditingController postcodeField = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      customer = Get.arguments;
      firstname = customer.billing!.firstName!;
      lastname = customer.billing!.lastName!;
      email = customer.billing!.email!;
      phone = customer.billing!.phone!;
      company = customer.billing!.company!;
      state = customer.billing!.state!;
      city = customer.billing!.city!;
      street = customer.billing!.address1!;
      number = customer.billing!.address2!;
      postcode = customer.billing!.postcode!;
      firstnameField.text = firstname;
      lastnameField.text = lastname;
      emailField.text = email;
      phoneField.text = phone;
      companyField.text = company;
      stateField.text = state;
      cityField.text = city;
      streetField.text = street;
      numberField.text = number;
      postcodeField.text = postcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppBarView(title: 'آدرس گیرنده'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              info(
                title: 'نام',
                subtitle: firstname,
                icon: Icons.person,
                controller: firstnameField,
                hint: 'نام را وارد کنید',
                onPressed: () => setState(() => firstname = firstnameField.text),
              ),
              info(
                title: 'نام خانوادگی',
                subtitle: lastname,
                icon: Icons.person,
                controller: lastnameField,
                hint: 'نام خانوادگی را وارد کنید',
                onPressed: () => setState(() => lastname = lastnameField.text),
              ),
              info(
                title: 'ایمیل',
                subtitle: email,
                icon: Icons.email,
                controller: emailField,
                hint: 'ایمیل را وارد کنید',
                textDirection: TextDirection.ltr,
                textInputType: TextInputType.emailAddress,
                onPressed: () => setState(() => email = emailField.text),
              ),
              info(
                title: 'شماره همراه',
                subtitle: phone,
                icon: Icons.phone_android,
                controller: phoneField,
                hint: 'شماره همراه را وارد کنید',
                textDirection: TextDirection.ltr,
                textInputType: TextInputType.number,
                onPressed: () => setState(() => phone = phoneField.text),
              ),
              info(
                title: 'شرکت / سازمان',
                subtitle: company,
                icon: Icons.business,
                controller: companyField,
                hint: 'نام شرکت یا سازمان را وارد کنید',
                onPressed: () => setState(() => company = companyField.text),
              ),
              info(
                title: 'استان',
                subtitle: state,
                icon: Icons.location_on,
                controller: stateField,
                hint: 'استان را وارد کنید',
                onPressed: () => setState(() => state = stateField.text),
              ),
              info(
                title: 'شهر',
                subtitle: city,
                icon: Icons.location_on,
                controller: cityField,
                hint: 'شهر را وارد کنید',
                onPressed: () => setState(() => city = cityField.text),
              ),
              info(
                title: 'خیابان',
                subtitle: street,
                icon: Icons.location_on,
                controller: streetField,
                hint: 'خیابان را وارد کنید',
                onPressed: () => setState(() => street = streetField.text),
              ),
              info(
                title: 'پلاک',
                subtitle: number,
                icon: Icons.location_on,
                controller: numberField,
                hint: 'پلاک را وارد کنید',
                onPressed: () => setState(() => number = numberField.text),
              ),
              info(
                title: 'کد پستی',
                subtitle: postcode,
                icon: Icons.location_on,
                controller: postcodeField,
                hint: 'کد پستی را وارد کنید',
                textDirection: TextDirection.ltr,
                textInputType: TextInputType.number,
                onPressed: () => setState(() => postcode = postcodeField.text),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: EasyButton(
                  idleStateWidget: const TextBodyMediumView('ثبت', color: Colors.white),
                  loadingStateWidget: const Padding(padding: EdgeInsets.all(10), child: Loading(color: Colors.white)),
                  buttonColor: ColorStyle.blueFav,
                  width: width,
                  height: 50,
                  borderRadius: width,
                  onPressed: () async {
                    if (formValidation()) {
                      dynamic jsonUpdateBilling = await httpRequest.updateBillingAddress(
                        id: customer.id.toString(),
                        firstname: firstname,
                        lastname: lastname,
                        email: email,
                        phone: phone,
                        company: company,
                        state: state,
                        city: city,
                        street: street,
                        number: number,
                        postcode: postcode,
                      );
                      if (jsonUpdateBilling != false) {
                        dynamic jsonUpdateShipping = await httpRequest.updateShippingAddress(
                          id: customer.id.toString(),
                          firstname: firstname,
                          lastname: lastname,
                          phone: phone,
                          company: company,
                          state: state,
                          city: city,
                          street: street,
                          number: number,
                          postcode: postcode,
                        );
                        if (jsonUpdateShipping != false) if (context.mounted) SnackBarView.show(context, 'آدرس شما ذخیره شد');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  info({
    required String title,
    required String subtitle,
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    TextInputType textInputType = TextInputType.name,
    TextDirection textDirection = TextDirection.rtl,
    required dynamic Function() onPressed,
  }) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      color: Colors.blue.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: TextBodyMediumView(title),
        subtitle: Padding(padding: const EdgeInsets.only(top: 10), child: TextBodyLargeView(subtitle, fontWeight: FontWeight.bold)),
        leading: Icon(icon),
        trailing: const Icon(Icons.edit),
        onTap: () => appDialogs.editeValue(
          context: context,
          value: subtitle,
          title: title,
          controller: controller,
          hint: hint,
          textInputType: textInputType,
          textDirection: textDirection,
          onPressed: onPressed,
        ),
      ),
    );
  }

  formValidation() {
    if (firstname != customer.billing!.firstName! ||
        lastname != customer.billing!.lastName ||
        email != customer.billing!.email ||
        phone != customer.billing!.phone ||
        company != customer.billing!.company ||
        state != customer.billing!.state ||
        city != customer.billing!.city ||
        street != customer.billing!.address1 ||
        number != customer.billing!.address2 ||
        postcode != customer.billing!.postcode) return true;
    return false;
  }
}
