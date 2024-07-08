import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yad_sys/connections/http_request.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/themes/color_style.dart';
import 'package:yad_sys/widgets/app_bar_view.dart';
import 'package:yad_sys/widgets/bottom_sheet/bottom_sheet_pick_image.dart';
import 'package:yad_sys/widgets/crop_image_view.dart';
import 'package:yad_sys/widgets/loading.dart';
import 'package:yad_sys/widgets/text_views/text_body_medium_view.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  HttpRequest httpRequest = HttpRequest();
  CustomerModel customer = CustomerModel();
  File? avatarFile;
  ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() => customer = Get.arguments);
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
              info(title: 'شناسه کاربری', subtitle: customer.id.toString(), icon: Icons.person_outline, trailing: null, onTap: null),
              info(title: 'نام کاربری', subtitle: customer.username!, icon: Icons.person_outline, trailing: null, onTap: null),
              info(title: 'نام', subtitle: customer.firstName!, icon: Icons.person, onTap: null),
              info(title: 'نام خانوادگی', subtitle: customer.lastName!, icon: Icons.person, onTap: null),
              info(title: 'ایمیل', subtitle: customer.email!, icon: Icons.email, onTap: null),
              info(title: 'شماره همراه', subtitle: customer.billing!.phone!, icon: Icons.phone_android, onTap: null),
              const SizedBox(height: 20),
              profileChangeView(),
              const SizedBox(height: 20),
              EasyButton(
                idleStateWidget: const TextBodyMediumView('ورود', color: Colors.white),
                loadingStateWidget: const Padding(padding: EdgeInsets.all(10), child: Loading(color: Colors.white)),
                buttonColor: ColorStyle.blueFav,
                width: width,
                height: 50,
                borderRadius: width,
                onPressed: () async {
                  dynamic jsonUpdate = await httpRequest.updateCustomer(id: customer.id.toString());
                },
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
    required void Function()? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: TextBodyMediumView(title, fontSize: 16),
        subtitle: Padding(padding: const EdgeInsets.only(top: 10), child: TextBodyMediumView(subtitle)),
        leading: Icon(icon),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  profileChangeView() {
    return CircleAvatar(
      radius: 140 / 2,
      backgroundImage: avatarFile == null ? CachedNetworkImageProvider(customer.avatarUrl!) : Image.file(File(avatarFile!.path)).image,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
          icon: const Icon(Icons.edit),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black54)),
          onPressed: () => bottomSheetPickImage(
            context: context,
            onTapCamera: () => pickImage(context: context, isFromGallery: false, cropType: true),
            onTapGallery: () => pickImage(context: context, isFromGallery: true, cropType: true),
          ),
        ),
      ),
    );
  }

  pickImage({required BuildContext context, required bool isFromGallery, required bool cropType}) async {
    XFile? image = await imagePicker.pickImage(source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    if (context.mounted) {
      Navigator.pop(context);
      cropImageView(context: context, imageFile: image!.path).then((value) => setState(() => avatarFile = File(value.path)));
    }
  }
}
