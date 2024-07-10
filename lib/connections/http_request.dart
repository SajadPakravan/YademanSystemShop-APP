import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:yad_sys/models/customer_model.dart';
import 'package:yad_sys/widgets/snack_bar_view.dart';

class HttpRequest {
  HttpRequest();

  String urlMain = 'yademansystem.ir';
  String key = '?consumer_key=ck_87e5e9071398235f51b9302d4d092254927b7d78';
  String secret = '&consumer_secret=cs_fb67b105c68da2be1592e8dd6dc1b56d29d67e84';

  get urlProducts => 'https://$urlMain/wp-json/wc/v3/products/';

  get urlCategories => 'https://$urlMain/wp-json/wc/v3/products/categories/';

  get urlProductReviews => 'https://$urlMain/wp-json/wc/v3/products/reviews/';

  get urlSignIn => 'https://$urlMain/wp-json/jwt-auth/v1/token/';

  get urlSignUp => 'https://yademansystem.ir/wp-json/wp/v2/users/register';

  get urlCustomers => 'https://$urlMain/wp-json/wc/v3/customers/';

  get urlUpload => 'https://$urlMain/wp-content/app-uploads/';

  get urlOrders => 'https://$urlMain/wp-json/wc/v3/orders/';

  getRequest({required String url, String id = '', String details = ''}) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final getRequest = await http.get(Uri.parse(url + id + key + secret + details), headers: headers);
      if (kDebugMode) print("Get Request >>>> ${getRequest.request}");

      dynamic json = jsonDecode(getRequest.body);

      if (getRequest.statusCode == 200) {
        if (kDebugMode) print("JSON >>>> $json");
        return json;
      } else {
        if (kDebugMode) {
          print("Status Code >>>:  ${getRequest.statusCode}");
          print("Json ERROR >>>:  $json");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("ERROR >>>> $e");
      // Get.offAll(const ConnectionError(), transition: Transition.fade, duration: const Duration(seconds: 1));
      return false;
    }
  }

  postRequest({required BuildContext context, required String url, required Map<String, dynamic> body, String? error}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      final postRequest = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      if (kDebugMode) print("postRequest.request >>>> ${postRequest.request}");
      dynamic json = jsonDecode(postRequest.body);
      if (postRequest.statusCode == 200) {
        if (kDebugMode) print("JSON >>>> $json");
        return json;
      } else {
        if (kDebugMode) {
          print("Status Code >>>:  ${postRequest.statusCode}");
          print("Json ERROR >>>:  $json");
        }
        if (error!.isEmpty) {
          if (context.mounted) SnackBarView.show(context, json['message']);
        } else {
          if (context.mounted) SnackBarView.show(context, error);
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR >>>> $e");
      }
      // Get.off(
      //   const ConnectionError(),
      //   transition: Transition.fade,
      //   duration: const Duration(seconds: 1),
      // );
    }
  }

  putRequest({required String url, String id = '', String details = '', required Map<String, dynamic> body}) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final putRequest = await http.put(Uri.parse(url + id + key + secret + details), headers: headers, body: jsonEncode(body));
      if (kDebugMode) print("Put Request >>>> ${putRequest.request}");

      dynamic json = jsonDecode(putRequest.body);

      if (putRequest.statusCode == 200) {
        if (kDebugMode) print("JSON >>>> $json");
        return json;
      } else {
        if (kDebugMode) {
          print("Status Code >>>:  ${putRequest.statusCode}");
          print("Json ERROR >>>:  $json");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) print("ERROR >>>> $e");
      // Get.offAll(const ConnectionError(), transition: Transition.fade, duration: const Duration(seconds: 1));
      return false;
    }
  }

  getProducts({
    int perPage = 10,
    int page = 1,
    String order = 'desc',
    String orderBy = 'date',
    String category = '',
    String onSale = '',
  }) async {
    String addCategory = '';
    String addOnSale = '';
    if (category.isNotEmpty) addCategory = '&category=$category';
    if (onSale.isNotEmpty) addOnSale = '&on_sale=$onSale';
    String details = "&per_page=$perPage&page=$page&order=$order&orderby=$orderBy$addCategory$addOnSale";
    return getRequest(url: urlProducts, details: details);
  }

  getProduct() async {
    int id = Get.arguments['id'];
    if (kDebugMode) print("Product id >>>> $id");
    return getRequest(url: urlProducts, id: id.toString());
  }

  getCategories({int parent = 0, int perPage = 10, String include = ""}) async {
    String addInclude = "";
    if (include.isNotEmpty) {
      addInclude = "&include=$include";
    }
    String details = "&parent=$parent&per_page=$perPage$addInclude&orderby=include";
    return getRequest(url: urlCategories, details: details);
  }

  getProductReviews({
    String status = "approved",
    int perPage = 5,
  }) async {
    int id = Get.arguments["id"];
    String details = "&product=$id&status=$status&per_page=$perPage";
    return getRequest(url: urlProductReviews, details: details);
  }

  signUp({required BuildContext context, required String email, required String password}) async {
    Map<String, String> body = {'username': email, 'email': email, 'password': password};
    return postRequest(context: context, url: urlSignUp, body: body, error: 'ایمیل وارد شده قبلا ثبت شده است');
  }

  signIn({required BuildContext context, required String email, required String password}) async {
    Map<String, String> body = {'username': email, 'password': password};
    return postRequest(context: context, url: urlSignIn, body: body, error: 'اطلاعات ورود صحیح نمی‌باشد');
  }

  getCustomer({required String email}) async {
    return getRequest(url: urlCustomers, details: '&email=$email');
  }

  updateCustomer({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
  }) async {
    Map<String, String> body = {'first_name': firstname, 'last_name': lastname, 'email': email};
    return putRequest(url: urlCustomers, id: id, body: body);
  }

  updateBillingAddress({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String company,
    required String state,
    required String city,
    required String street,
    required String number,
    required String postcode,
  }) async {
    Billing billing = Billing();
    billing.firstName = firstname;
    billing.lastName = lastname;
    billing.email = email;
    billing.phone = phone;
    billing.company = company;
    billing.country = 'IR';
    billing.state = state;
    billing.city = city;
    billing.address1 = street;
    billing.address2 = number;
    billing.postcode = postcode;
    return putRequest(url: urlCustomers, id: id, body: {'billing': billing.toJson()});
  }

  updateShippingAddress({
    required String id,
    required String firstname,
    required String lastname,
    required String phone,
    required String company,
    required String state,
    required String city,
    required String street,
    required String number,
    required String postcode,
  }) async {
    Shipping shipping = Shipping();
    shipping.firstName = firstname;
    shipping.lastName = lastname;
    shipping.phone = phone;
    shipping.company = company;
    shipping.country = 'IR';
    shipping.state = state;
    shipping.city = city;
    shipping.address1 = street;
    shipping.address2 = number;
    shipping.postcode = postcode;
    return putRequest(url: urlCustomers, id: id, body: {'shipping': shipping.toJson()});
  }

  uploadAvatar({required BuildContext context, required String userId, required File avatar}) async {
    final request = http.MultipartRequest('POST', Uri.parse(urlUpload));
    request.fields['user_id'] = userId;
    request.files.add(
      http.MultipartFile(
        'file',
        http.ByteStream(avatar.openRead()),
        await avatar.length(),
        filename: basename(avatar.path),
      ),
    );
    var response = await request.send();
    dynamic json = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      if (kDebugMode) print('JSON >>>> $json');
      return json;
    } else {
      if (kDebugMode) {
        print("Status Code >>>:  ${response.statusCode}");
        print("Json ERROR >>>:  $json");
      }
      if (context.mounted) SnackBarView.show(context, json['message']);
      return false;
    }
  }

  getSearchProduct({
    required String search,
    int perPage = 100,
    int page = 1,
  }) async {
    var more = "&&search=$search&per_page=$perPage&page=$page";

    final requestGetSearchProducts = await http.get(
      Uri.parse(urlProducts + key + secret + more),
    );

    dynamic jsonGetSearchProducts;

    if (requestGetSearchProducts.statusCode == 200) {
      jsonGetSearchProducts = jsonDecode(requestGetSearchProducts.body);

      if (jsonGetSearchProducts.toString() == "[]") {
        return "empty";
      } else {
        return jsonGetSearchProducts;
      }
    } else {
      print("requestGetProducts >>>: ${requestGetSearchProducts.request}");
      print("requestGetProducts_statusCode >>>:  ${requestGetSearchProducts.statusCode}");
      print("jsonGetProducts_error >>>:  $jsonGetSearchProducts");
      return false;
    }
  }
}
