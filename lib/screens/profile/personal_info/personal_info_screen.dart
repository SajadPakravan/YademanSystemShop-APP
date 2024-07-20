import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/tools/app_cache.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/app_dialogs.dart';
import 'package:yad_sys/widgets/bottom_sheet/bottom_sheet_pick_image.dart';
import 'package:yad_sys/widgets/crop_image_view.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/snack_bar_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_large_view.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  HttpRequest httpRequest = HttpRequest();
  CustomerModel customer = CustomerModel();
  AppDialogs appDialogs = AppDialogs();
  String firstname = '';
  String lastname = '';
  String email = '';
  TextEditingController firstnameField = TextEditingController();
  TextEditingController lastnameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  dynamic avatarFile;
  ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {
      customer = Get.arguments;
      firstname = customer.firstname!;
      lastname = customer.lastname!;
      email = customer.email!;
      firstnameField.text = customer.firstname!;
      lastnameField.text = customer.lastname!;
      emailField.text = customer.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppBarView(title: 'مشخصات فردی'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              info(
                title: 'نام',
                subtitle: firstname,
                icon: Icons.person,
                controller: firstnameField,
                hint: 'نام خود را وارد کنید',
                onPressed: () => setState(() => firstname = firstnameField.text),
              ),
              info(
                title: 'نام خانوادگی',
                subtitle: lastname,
                icon: Icons.person,
                controller: lastnameField,
                hint: 'نام خانوادگی خود را وارد کنید',
                onPressed: () => setState(() => lastname = lastnameField.text),
              ),
              info(
                title: 'ایمیل',
                subtitle: email,
                icon: Icons.email,
                controller: emailField,
                hint: 'ایمیل خود را وارد کنید',
                textDirection: TextDirection.ltr,
                textInputType: TextInputType.emailAddress,
                onPressed: () => setState(() => email = emailField.text),
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
                    if (firstname != customer.firstname! || lastname != customer.lastname || email != customer.email) {
                      dynamic jsonUpdate = await httpRequest.updateCustomer(
                        id: customer.id.toString(),
                        firstname: firstname,
                        lastname: lastname,
                        email: email,
                      );
                      if (jsonUpdate != false) {
                        if (context.mounted) {
                          dynamic jsonUpdateUser = await httpRequest.updateUser(context: context, firstname: firstname, lastname: lastname);
                          if (jsonUpdateUser != false) {
                            AppCache cache = AppCache();
                            await cache.setString('email', email);
                            await cache.setString('name', '$firstname $lastname');
                            if (context.mounted) SnackBarView.show(context, 'اطلاعات شما ذخیره شد');
                          }
                        }
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
    Widget? trailing = const Icon(Icons.edit),
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
        trailing: trailing,
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

  profileChangeView() {
    return CircleAvatar(
      radius: 140 / 2,
      backgroundImage: avatarFile == null ? CachedNetworkImageProvider(customer.avatarUrl!) : Image.file(File(avatarFile.path)).image,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
          icon: const Icon(Icons.edit),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black54)),
          onPressed: () => bottomSheetPickImage(
            context: context,
            onTapCamera: () => pickImage(context: context, gallery: false),
            onTapGallery: () => pickImage(context: context, gallery: true),
          ),
        ),
      ),
    );
  }

  pickImage({required BuildContext context, required bool gallery}) async {
    XFile? image = await imagePicker.pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
    if (context.mounted) {
      Navigator.pop(context);
      cropImageView(context: context, imageFile: image!.path).then((value) => setState(() => avatarFile = File(value.path)));
    }
  }
}
