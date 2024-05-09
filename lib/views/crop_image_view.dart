import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:yad_sys/themes/color_style.dart';

Future<CroppedFile> cropImageView({
  required BuildContext context,
  required String imageFile,
  required CropStyle cropStyle,
}) async {
  CroppedFile? croppedFile0;
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile,
    cropStyle: cropStyle,
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
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.page,
        boundary: const CroppieBoundary(
          width: 250,
          height: 220,
        ),
        barrierColor: Colors.transparent,
        viewPort: CroppieViewPort(width: 160, height: 160, type: cropStyle == CropStyle.circle ? "circle" : "square"),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
        enableResize: true,
        enableOrientation: true,
        enforceBoundary: true,
      ),
    ],
  );
  if (croppedFile != null) {
    croppedFile0 = croppedFile;
  }
  return croppedFile0!;
}
