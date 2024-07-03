import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:yad_sys/connections/http_request.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  bool attributeEmpty = false;

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  HttpRequest httpRequest = HttpRequest();
  TextEditingController name = TextEditingController();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributeDescription = TextEditingController();
  TextEditingController regularPrice = TextEditingController();
  TextEditingController salePrice = TextEditingController();

  bool visibleErrorName = false;
  String errorName = '';

  bool visibleErrorEmpty = false;
  List<String> attributeNameLst = [];
  List<String> attributeDescriptionLst = [];
  List<dynamic> attributes = [];

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImage = [];
  List<String> imageLink = [];
  List<dynamic> images = [];
  bool progress = false;

  FocusNode textFocusNode = FocusNode();

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
  bool check6 = false;
  bool check7 = false;
  bool check8 = false;
  bool check9 = false;
  List<dynamic> categories = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Config().backgroundColorPage,
        appBar: AppBar(
          title: const Text("افزودن محصول"),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    field(
                      labelText: 'عنوان محصول',
                      controller: name,
                    ),
                    field(
                      labelText: 'قیمیت / تومان',
                      keyboardType: TextInputType.number,
                      controller: regularPrice,
                    ),
                    field(
                      labelText: 'قیمت ویژه / تومان',
                      keyboardType: TextInputType.number,
                      controller: salePrice,
                    ),
                    productAttributes(),
                    productImage(),
                    productCategory(),
                    progress
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            child: const Text("ثبت محصول"),
                            onPressed: () {
                              addProduct();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  field({
    required String labelText,
    required TextEditingController controller,
    int maxLines = 1,
    double minHeight = 0.07,
    double maxHeight = 0.07,
    TextInputType keyboardType = TextInputType.text,
    dynamic focusNode,
  }) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        focusNode: focusNode,
        maxLines: maxLines,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: height * minHeight,
            maxHeight: height * maxHeight,
          ),
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        keyboardType: keyboardType,
        controller: controller,
      ),
    );
  }

  addAttributeDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                field(
                  labelText: 'عنوان',
                  focusNode: textFocusNode,
                  controller: attributeName,
                ),
                field(
                  labelText: 'توضیحات',
                  maxLines: 10,
                  minHeight: 0.3,
                  maxHeight: 0.6,
                  controller: attributeDescription,
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (attributeName.text.isNotEmpty && attributeDescription.text.isNotEmpty) {
                  setState(() {
                    attributeNameLst.add(attributeName.text);
                    attributeDescriptionLst.add(attributeDescription.text);

                    attributes.add({
                      "name": attributeName.text,
                      "visible": true,
                      "options": [attributeDescription.text]
                    });

                    widget.attributeEmpty = false;

                    attributeName.clear();
                    attributeDescription.clear();

                    FocusScope.of(context).requestFocus(textFocusNode);
                  });
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  attributeName.clear();
                  attributeDescription.clear();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  productAttributes() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  label: const Text("افزودن ویژگی"),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addAttributeDialog();
                  },
                ),
              ),
              attributeDetails(),
            ],
          ),
        ),
      ],
    );
  }

  attributeDetails() {
    return Theme(
      data: ThemeData(
        // dialogBackgroundColor: Config().backgroundColorPage,
        fontFamily: "Shabnam",
      ),
      child: Builder(builder: (context) {
        return ElevatedButton(
            child: const Text("نمایش ویژگی‌ها"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: attributeNameLst.isEmpty
                            ? const Text("ویژگی وجود ندارد")
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: attributeNameLst.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade700,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete_rounded,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      attributeNameLst.removeAt(index);
                                                      attributeDescriptionLst.removeAt(index);
                                                      attributes.removeAt(index);
                                                      if (attributeNameLst.isEmpty) {
                                                        setState(() {
                                                          widget.attributeEmpty = true;
                                                        });
                                                      }
                                                    });
                                                  },
                                                ),
                                                Text(attributeNameLst[index]),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Text(attributeDescriptionLst[index]),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  );
                },
              );
            });
      }),
    );
  }

  showSelectedImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedImage.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(File(selectedImage[index].path)),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    selectedImage.removeAt(index);
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }

  productImage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  label: const Text("انتخاب عکس محصول"),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    chooseImage();
                  },
                ),
              ),
              selectedImage.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.delete_sweep_rounded),
                      onPressed: () {
                        setState(() {
                          selectedImage.clear();
                        });
                      },
                    ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: selectedImage.isEmpty ? const Text("عکسی انتخاب نشده است") : showSelectedImage(),
          ),
        ],
      ),
    );
  }

  chooseImage() async {
    dynamic image;

    image = await _picker.pickMultiImage(
        maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height * 0.3);

    setState(() {
      selectedImage += image;
    });
  }

  productCategory() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  label: const Text("انتخاب دسته‌بندی محصول"),
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
              ),
              categories.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.delete_sweep_rounded),
                      onPressed: () {
                        setState(() {
                          categories.clear();
                          check1 = false;
                          check2 = false;
                          check3 = false;
                          check4 = false;
                          check5 = false;
                          check6 = false;
                          check7 = false;
                          check8 = false;
                          check9 = false;
                        });
                      },
                    ),
            ],
          ),
          CheckboxListTile(
            title: const Text("اسپیکر"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check1,
            onChanged: (value) {
              setState(() {
                check1 = value!;
              });
              categoryAddOrRemove(check1, 150);
            },
          ),
          CheckboxListTile(
            title: const Text("پرینتر"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check2,
            onChanged: (value) {
              setState(() {
                check2 = value!;
              });
              categoryAddOrRemove(check2, 154);
            },
          ),
          CheckboxListTile(
            title: const Text("تجهیزات بازی"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check3,
            onChanged: (value) {
              setState(() {
                check3 = value!;
              });
              categoryAddOrRemove(check3, 157);
            },
          ),
          CheckboxListTile(
            title: const Text("تجهیزات ذخیره سازی"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check4,
            onChanged: (value) {
              setState(() {
                check4 = value!;
              });
              categoryAddOrRemove(check4, 144);
            },
          ),
          CheckboxListTile(
            title: const Text("قطعات داخلی کامپیوتر"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check5,
            onChanged: (value) {
              setState(() {
                check5 = value!;
              });
              categoryAddOrRemove(check5, 143);
            },
          ),
          CheckboxListTile(
            title: const Text("کابل"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check6,
            onChanged: (value) {
              setState(() {
                check6 = value!;
              });
              categoryAddOrRemove(check6, 15);
            },
          ),
          CheckboxListTile(
            title: const Text("لپ تاپ"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check7,
            onChanged: (value) {
              setState(() {
                check7 = value!;
              });
              categoryAddOrRemove(check7, 145);
              addCategory(145);
            },
          ),
          CheckboxListTile(
            title: const Text("لوازم کامپیوتر"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check8,
            onChanged: (value) {
              setState(() {
                check8 = value!;
              });
              categoryAddOrRemove(check8, 146);
            },
          ),
          CheckboxListTile(
            title: const Text("هدفون و هندزفری"),
            controlAffinity: ListTileControlAffinity.leading,
            value: check9,
            onChanged: (value) {
              setState(() {
                check9 = value!;
              });
              categoryAddOrRemove(check9, 151);
            },
          ),
        ],
      ),
    );
  }

  categoryAddOrRemove(bool check, int categoryId) {
    if (check) {
      setState(() {
        addCategory(categoryId);
      });
      print(categories);
    } else {
      setState(() {
        removeCategory(categoryId);
      });
      print(categories);
    }
  }

  addCategory(int categoryId) {
    setState(() {
      categories.add({"id": categoryId});
    });
  }

  removeCategory(int categoryId) {
    setState(() {});
  }

  uploadImage() async {
    setState(() {
      imageLink.clear();
      images.clear();
    });

    for (var image in selectedImage) {
      String fileName = image.name.toString();
      // print("fileName >>>: $fileName");

      List<int> imageBytes = await image.readAsBytes();
      // print("imageBytes >>>: $imageBytes");

      String base64Image = base64Encode(imageBytes).toString();
      // print("base64Image >>>: $base64Image");

      final requestUploadImage = await http.post(
        Uri.parse('https://sajadpakravan.ir/app/upload_image.php'),
        body: {
          "image": base64Image,
          "name": fileName,
        },
      );

      dynamic jsonUploadImage;

      if (requestUploadImage.statusCode == 200) {
        jsonUploadImage = jsonDecode(requestUploadImage.body);
        print(" json_UploadImage >>>: $jsonUploadImage");

        setState(() {
          imageLink.add(jsonUploadImage["image_link"]);
          images.add({"src": jsonUploadImage["image_link"]});
          print("srcLink >>>: $images");
        });
      } else {
        print("request_UploadImage.statusCode >>>: ${requestUploadImage.statusCode}");
      }
    }
  }

  addProduct() async {
    if (selectedImage.isEmpty) {
      snackBar(
        color: Colors.blue.shade700,
        message: "برای محصول خود تصویری انتخاب کنید",
      );
    } else if (categories.isEmpty) {
      snackBar(
        color: Colors.blue.shade700,
        message: "برای محصول خود یک دسته‌بندی انتخاب کنید",
      );
    } else {
      setState(() {
        progress = true;
      });
      await uploadImage();

      dynamic jsonCreateProduct = httpRequest.createProduct(
        name: name.text,
        categories: categories,
        images: images,
        attributes: attributes,
        regularPrice: '',
        salePrice: '',
      );

      print("jsonCreateProduct >>>: $jsonCreateProduct");

      if (jsonCreateProduct == false) {
        snackBar(
          color: Colors.red.shade800,
          message: "خطا در افزودن محصول",
        );
      } else {
        setState(() {
          progress = false;
        });
        snackBar(
          color: Colors.green.shade800,
          message: "محصول با موفقيت اضافه شد",
        );
      }
    }
  }

  snackBar({required Color color, required String message}) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
