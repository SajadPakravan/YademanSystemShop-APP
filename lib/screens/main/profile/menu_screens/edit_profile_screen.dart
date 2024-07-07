import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yad_sys/connections/http_request.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  HttpRequest httpRequest = HttpRequest();
  bool progress = true;
  int id = 0;
  String token = "";

  TextEditingController fieldFirstName = TextEditingController();
  TextEditingController fieldLastName = TextEditingController();
  TextEditingController fieldEmail = TextEditingController();

  bool visibleErrorEmpty = false;

  final ImagePicker _picker = ImagePicker();
  dynamic selectedImage;
  String avatarImageLink = "";
  String? images;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  loadDetail() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // dynamic jsonGetUser = await httpRequest.getCustomer();

    // if (jsonGetUser == false) {
    //   snackBar(color: Colors.red.shade800, message: "خطا در دريافت اطلاعات");
    //   setState(() {
    //     progress = false;
    //   });
    // } else {
    //   setState(() {
    //     avatarImageLink = jsonGetUser[0]['avatar_urls']['96'];
    //     fieldFirstName.text = jsonGetUser[0]["name"];
    //     fieldLastName.text = jsonGetUser[0]["last_name"];
    //     fieldEmail.text = sharedPreferences.getString("email")!;
    //     progress = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Config().backgroundColorPage,
        appBar: AppBar(
          title: const Text("ویرایش پروفایل"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: editProfileContent(width, height),
          ),
        ),
      ),
    );
  }

  chooseImage() async {
    dynamic image;

    image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      selectedImage = image;
    });
  }

  uploadImage() async {
    setState(() {
      images = null;
    });

    String fileName = selectedImage.name.toString();
    // print("fileName >>>: $fileName");

    List<int> imageBytes = await selectedImage.readAsBytes();
    // print("imageBytes >>>: $imageBytes");

    String base64Image = base64Encode(imageBytes).toString();
    // print("base64Image >>>: $base64Image");

    dynamic jsonUploadImage = await httpRequest.uploadImage(
      base64Image: base64Image,
      fileName: fileName,
    );

    if (jsonUploadImage == false) {
      snackBar(color: Colors.red.shade800, message: "خطا در آپلود عكس");
      setState(() {
        progress = false;
      });

    } else {
      setState(() {
        progress = false;
        avatarImageLink = jsonUploadImage["image_link"]["src"];
        print("avatarImageLink >>>: $avatarImageLink");
      });
    }
  }

  editProfileContent(var width, var height) {
    if (progress) {
      return const CircularProgressIndicator();
    } else {
      return SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(width),
                    child: selectedImage == null
                        ? Image.network(
                            avatarImageLink,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.account_circle,
                                size: MediaQuery.of(context).size.width * 0.3,
                                color: Colors.red,
                              );
                            },
                          )
                        : Image.file(
                            File(selectedImage.path),
                            width: width * 0.3,
                            height: width * 0.3,
                          ),
                  ),
                  InkWell(
                    child: Transform(
                      transform: Matrix4.translationValues(width * 0.04, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width),
                        child: InkWell(
                          child: Container(
                            color: Colors.blue.shade600,
                            width: width * 0.08,
                            height: width * 0.08,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: width * 0.05,
                            ),
                          ),
                          onTap: () {
                            chooseImage();
                          },
                        ),
                      ),
                    ),
                    onTap: () {
                      chooseImage();
                    },
                  ),
                ],
              ),
              editProfileForm("نام", Icons.person, height, fieldFirstName),
              editProfileForm(
                  "نام خانوادگی", Icons.person, height, fieldLastName),
              editProfileForm(
                  "ایمیل", Icons.email_rounded, height, fieldEmail),
              Visibility(
                maintainAnimation: true,
                maintainState: true,
                visible: visibleErrorEmpty,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'لطفا ایمیل را وارد کنید',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                label: const Text("بروزرسانی"),
                icon: const Icon(Icons.check),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                ),
                onPressed: () {
                  if (fieldEmail.text.isNotEmpty) {
                    setState(() {
                      progress = true;
                    });
                    if (selectedImage != null) {
                      uploadImage();
                    }
                    updateUser(
                      firstName: fieldFirstName.text,
                      lastName: fieldLastName.text,
                      email: fieldEmail.text,
                    );
                  } else {
                    setState(() {
                      visibleErrorEmpty = true;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  editProfileForm(String labelText, IconData iconData, var height,
      TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(iconData),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: height * 0.07,
          ),
        ),
        controller: controller,
      ),
    );
  }

  updateUser({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    dynamic jsonUpdateUser = await httpRequest.updateUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      avatarImageLink: avatarImageLink,
    );

    switch (jsonUpdateUser) {
      case "نشانی ایمیل نامعتبر است.":
        {
          snackBar(
              color: Colors.red.shade800,
              message: "ايميل وارد شده نامعتبر است");
          setState(() {
            progress = false;
          });
          break;
        }
      default:
        {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("email", jsonUpdateUser["email"]);
          sharedPreferences.setString("name", jsonUpdateUser["name"]);
          sharedPreferences.setString(
              "avatar", jsonUpdateUser['avatar_urls']['96']);

          snackBar(
              color: Colors.green.shade800,
              message: "اطلاعات شما با موفقيت بروزرسانی شد");

          setState(() {
            progress = false;
          });
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
