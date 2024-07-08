import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:yad_sys/themes/color_style.dart';

Future<CroppedFile> cropImageView({required BuildContext context, required String imageFile}) async {
  CroppedFile? croppedFile0;
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile,
    maxWidth: 512,
    maxHeight: 512,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: '',
        toolbarColor: ColorStyle.colorBlack0a,
        toolbarWidgetColor: ColorStyle.colorWhite,
        activeControlsWidgetColor: ColorStyle.colorPurple,
        lockAspectRatio: false,
      ),
      IOSUiSettings(title: 'Cropper'),
    ],
  );
  if (croppedFile != null) croppedFile0 = croppedFile;
  return croppedFile0!;
}
