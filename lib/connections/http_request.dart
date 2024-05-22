import 'dart:convert';
import 'package:yad_sys/screens/connection_error.dart';
import 'package:yad_sys/widgets/app_dialogs.dart';
import 'package:yad_sys/widgets/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  HttpRequest();
  AppDialogs appDialogs = AppDialogs();
  AppSnackBar appSnackBar = AppSnackBar();

  String urlMain = "yademansystem.ir";
  String key = "?consumer_key=ck_87e5e9071398235f51b9302d4d092254927b7d78";
  String secret = "&consumer_secret=cs_fb67b105c68da2be1592e8dd6dc1b56d29d67e84";

  get urlProducts => "https://$urlMain/wp-json/wc/v3/products/";

  get urlCategories => "https://$urlMain/wp-json/wc/v3/products/categories/";

  get urlProductReviews => "https://$urlMain/wp-json/wc/v3/products/reviews/";

  get urlSignIn => "https://$urlMain/wp-json/jwt-auth/v1/token/";

  get urlSignUp => "https://yademansystem.ir/wp-json/wp/v2/users/register";

  get urlUsers => "https://$urlMain/wp-json/wc/v3/customers/";

  get urlOrders => "https://$urlMain/wp-json/wc/v3/orders/";

  getRequest({required String url, String id = "", String details = ""}) async {
    try {
      final getRequest = await http.get(Uri.parse(url + id + key + secret + details));
      if (kDebugMode) {
        print("Get Request >>>> ${getRequest.request}");
      }
      dynamic json = jsonDecode(getRequest.body);
      if (getRequest.statusCode == 200) {
        if (kDebugMode) {
          print("JSON >>>> $json");
        }
        return json;
      } else {
        if (kDebugMode) {
          print("Request ERROR >>>: ${getRequest.request}");
          print("Status Code >>>:  ${getRequest.statusCode}");
          print("Json ERROR >>>:  $json");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR >>>> $e");
      }
      // Get.offAll(const ConnectionError(), transition: Transition.fade, duration: const Duration(seconds: 1));
      return false;
    }
  }

  postRequest({required String url, required Map<String, dynamic> body, required String error}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      final postRequest = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      if (kDebugMode) {
        print("postRequest.request >>>> ${postRequest.request}");
      }
      dynamic json;
      if (postRequest.statusCode == 200) {
        json = jsonDecode(postRequest.body);
        if (kDebugMode) {
          print("JSON >>>> $json");
        }
        return json;
      } else {
        if (kDebugMode) {
          print("Request ERROR >>>: ${postRequest.request}");
          print("Status Code >>>:  ${postRequest.statusCode}");
          json = jsonDecode(postRequest.body);
          print("Json ERROR >>>:  $json");
        }
        // ignore: use_build_context_synchronously
        // appSnackBar.error(context: context, message: error);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR >>>> $e");
      }
      Get.off(
        const ConnectionError(),
        transition: Transition.fade,
        duration: const Duration(seconds: 1),
      );
    }
  }

  getProducts({
    int perPage = 10,
    int page = 1,
    String order = "desc",
    String orderby = "date",
    String category = "",
    String onSale = "",
  }) async {
    String addCategory = "";
    String addOnSale = "";
    if (category.isNotEmpty) {
      addCategory = "&category=$category";
    }
    if (onSale.isNotEmpty) {
      addOnSale = "&on_sale=$onSale";
    }
    String details = "&per_page=$perPage&page=$page&order=$order&orderby=$orderby$addCategory$addOnSale";
    return getRequest(url: urlProducts, details: details);
  }

  getProduct() async {
    int id = Get.arguments["id"];
    if (kDebugMode) {
      print("product id >>>> $id");
    }
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

  signUp({required String email, required String password}) async {
    Map<String, String> body = {"username": email, "email": email, "password": password};
    return postRequest(url: urlSignUp, body: body, error: "ایمیل وارد شده قبلا ثبت شده است");
  }

  signIn({required String email, required String password}) async {
    Map<String, String> body = {"username": email, "password": password};
    return postRequest(url: urlSignIn, body: body, error: "اطلاعات ورود صحیح نمی‌باشد");
  }

  getUser({String role = "all"}) async {
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    String email = sharePref.getString("email")!;
    // String token = sharePref.getString("token")!;
    String more = "&role=$role&search=$email";
    final requestGetUser = await http.get(
      Uri.parse(urlUsers + key + secret + more),
    );

    dynamic jsonGetUser;

    if (requestGetUser.statusCode == 200) {
      jsonGetUser = jsonDecode(requestGetUser.body);
      return jsonGetUser;
    } else {
      print("requestGetUser.request >>>:  ${requestGetUser.request}");
      print("requestGetUser.statusCode >>>:  ${requestGetUser.statusCode}");
      print("requestGetUser.body_Error >>>:  ${requestGetUser.body}");
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

  updateUser({
    required String firstName,
    required String lastName,
    required String email,
    required String avatarImageLink,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("user_id")!;
    String token = sharedPreferences.getString("token")!;

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> body = {
      "first_name": firstName,
      "last_name": lastName,
      "name": "$firstName $lastName",
      "email": email,
      "avatar_urls": {
        "24": avatarImageLink,
        "48": avatarImageLink,
        "96": avatarImageLink,
      },
    };

    final requestUpdateUser = await http.post(
      Uri.parse(urlUsers + id.toString()),
      headers: headers,
      body: jsonEncode(body),
    );

    dynamic jsonUpdateUser;

    if (requestUpdateUser.statusCode == 200) {
      jsonUpdateUser = jsonDecode(requestUpdateUser.body);
      return jsonUpdateUser;
    } else {
      print("requestUpdateUser.statusCodee >>>:  ${requestUpdateUser.statusCode}");
      print("requestUpdateUser.body_Error >>>:  ${requestUpdateUser.body}");
      jsonUpdateUser = jsonDecode(requestUpdateUser.body);
      return jsonUpdateUser['message'];
    }
  }

  uploadImage({
    required String base64Image,
    required String fileName,
  }) async {
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
      return jsonUploadImage;
    } else {
      print("requestUploadImage.statusCode >>>: ${requestUploadImage.statusCode}");
      return false;
    }
  }

  createProduct({
    required String name,
    required String regularPrice,
    required String salePrice,
    required List<dynamic> categories,
    required List<dynamic> images,
    required List<dynamic> attributes,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {
      "name": name,
      "regular_price": regularPrice,
      "sale_price": salePrice,
      "categories": categories,
      "images": images,
      "attributes": attributes,
    };
    print(body);
    final requestCreateProduct = await http.post(
      Uri.parse(urlProducts + key + secret),
      headers: headers,
      body: jsonEncode(body),
    );

    dynamic jsonCreateProduct;

    if (requestCreateProduct.statusCode == 201) {
      jsonCreateProduct = jsonDecode(requestCreateProduct.body);
      return jsonCreateProduct;
    } else {
      print("requestGetCategoryProducts >>>: ${requestCreateProduct.request}");
      print("requestGetCategoryProducts_statusCode >>>:  ${requestCreateProduct.statusCode}");
      print("jsonGetCategoryProducts_error >>>:  $jsonCreateProduct");
      return false;
    }
  }

  getBillAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("user_id")!;
    String token = sharedPreferences.getString("token")!;

    final requestGetBillAddress = await http.get(
      Uri.parse(urlUsers + id.toString()),
      headers: {"Authorization": "Bearer $token"},
    );
    print("requestGetBillAddress >>>: ${requestGetBillAddress.request}");

    dynamic jsonGetBillAddress;

    if (requestGetBillAddress.statusCode == 200) {
      jsonGetBillAddress = jsonDecode(requestGetBillAddress.body);
      print("jsonGetBillAddress_body >>>:  ${jsonGetBillAddress["billing"]}");
      return jsonGetBillAddress["billing"];
    } else {
      print("requestGetCustomer_statusCode >>>:  ${requestGetBillAddress.statusCode}");
      print("jsonGetCustomer_body_Error >>>:  ${requestGetBillAddress.body}");
      return false;
    }
  }

  getShippingAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("user_id")!;
    String token = sharedPreferences.getString("token")!;

    final requestGetShippingAddress = await http.get(
      Uri.parse(urlUsers + id.toString()),
      headers: {"Authorization": "Bearer $token"},
    );
    print("requestGetShippingAddress >>>: ${requestGetShippingAddress.request}");

    dynamic jsonGetShippingAddress;

    if (requestGetShippingAddress.statusCode == 200) {
      jsonGetShippingAddress = jsonDecode(requestGetShippingAddress.body);
      print("jsonGetBillAddress_body >>>:  ${jsonGetShippingAddress["billing"]}");
      return jsonGetShippingAddress["billing"];
    } else {
      print("requestGetCustomer_statusCode >>>:  ${requestGetShippingAddress.statusCode}");
      print("jsonGetCustomer_body_Error >>>:  ${requestGetShippingAddress.body}");
      return false;
    }
  }

  updateBillAddress({
    required String firstName,
    required String lastName,
    required String phone,
    required String state,
    required String city,
    required String address_1,
    required String address_2,
    required String postcode,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("user_id")!;
    String email = sharedPreferences.getString("email")!;

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {
      "billing": {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "country": "IR",
        "state": state,
        "city": city,
        "address_1": address_1,
        "address_2": address_2,
        "postcode": postcode,
      },
    };

    final requestUpdateBillAddress = await http.put(
      Uri.parse(urlUsers + id.toString() + key + secret),
      headers: headers,
      body: jsonEncode(body),
    );
    print("requestUpdateBillAddress >>>: ${requestUpdateBillAddress.request}");

    dynamic jsonUpdateBillAddress;

    if (requestUpdateBillAddress.statusCode == 200) {
      jsonUpdateBillAddress = jsonDecode(requestUpdateBillAddress.body);
      print("jsonUpdateBillAddress_body >>>:  ${jsonUpdateBillAddress["billing"]}");
    } else {
      print("requestUpdateBillAddress.statusCode >>>:  ${requestUpdateBillAddress.statusCode}");
      print("requestUpdateBillAddress.body_Error >>>:  ${requestUpdateBillAddress.body}");
      return false;
    }
  }

  updateShippingAddress({
    required String firstName,
    required String lastName,
    required String state,
    required String city,
    required String address_1,
    required String address_2,
    required String postcode,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("user_id")!;

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {
      "billing": {
        "first_name": firstName,
        "last_name": lastName,
        "country": "IR",
        "state": state,
        "city": city,
        "address_1": address_1,
        "address_2": address_2,
        "postcode": postcode,
      },
    };

    final requestUpdateShippingAddress = await http.put(
      Uri.parse(urlUsers + id.toString() + key + secret),
      headers: headers,
      body: jsonEncode(body),
    );
    print("requestUpdateShippingAddress >>>: ${requestUpdateShippingAddress.request}");

    dynamic jsonUpdateShippingAddress;

    if (requestUpdateShippingAddress.statusCode == 200) {
      jsonUpdateShippingAddress = jsonDecode(requestUpdateShippingAddress.body);
      print("jsonUpdateBillAddress_body >>>:  ${jsonUpdateShippingAddress["billing"]}");
    } else {
      print("requestUpdateShippingAddress.statusCode >>>:  ${requestUpdateShippingAddress.statusCode}");
      print("requestUpdateShippingAddress.body_Error >>>:  ${requestUpdateShippingAddress.body}");
      return false;
    }
  }

  createOrder({
    required String status,
    required List<Map<String, int>> lineItems,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? customerId = sharedPreferences.getInt("user_id");

    if (customerId == 0) {
      // MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
    } else {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      dynamic jsonGetBillAddress = await getBillAddress();
      dynamic jsonGetShippingAddress = await getShippingAddress();

      print(jsonGetBillAddress);

      Map<String, dynamic> body = {
        "payment_method_title": "سفارش از اپلیکیشن",
        "customer_id": customerId,
        "status": status,
        "billing": jsonGetBillAddress,
        "shipping": jsonGetShippingAddress,
        "line_items": lineItems,
        "shipping_lines": [
          {"method_id": "flat_rate", "method_title": "Flat Rate", "total": "30000"}
        ]
      };
      final requestCreateOrder = await http.post(
        Uri.parse(urlOrders + key + secret),
        headers: headers,
        body: jsonEncode(body),
      );

      dynamic jsonCreateOrder;

      print(jsonEncode(body));

      if (requestCreateOrder.statusCode == 201) {
        jsonCreateOrder = jsonDecode(requestCreateOrder.body);
        return jsonCreateOrder;
      } else {
        print("requestCreateOrder >>>: ${requestCreateOrder.request}");
        print("requestCreateOrder_statusCode >>>:  ${requestCreateOrder.statusCode}");
        print("jsonCreateOrder_error >>>:  $jsonCreateOrder");
        return false;
      }
    }
  }

  updateOrder({
    required String status,
    required Map<String, int> lineItems,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? customerId = sharedPreferences.getInt("user_id");

    if (customerId == 0) {
      // MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
    } else {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      dynamic jsonGetBillAddress = await getBillAddress();
      dynamic jsonGetShippingAddress = await getShippingAddress();

      print(jsonGetBillAddress);

      Map<String, dynamic> body = {
        "payment_method_title": "سفارش از اپلیکیشن",
        "customer_id": customerId,
        "status": status,
        "billing": jsonGetBillAddress,
        "shipping": jsonGetShippingAddress,
        "line_items": [lineItems],
        "shipping_lines": [
          {"method_id": "flat_rate", "method_title": "Flat Rate", "total": "30000"}
        ]
      };
      final requestCreateOrder = await http.post(
        Uri.parse(urlOrders + key + secret),
        headers: headers,
        body: jsonEncode(body),
      );

      dynamic jsonCreateOrder;

      if (requestCreateOrder.statusCode == 201) {
        jsonCreateOrder = jsonDecode(requestCreateOrder.body);
        return jsonCreateOrder;
      } else {
        print("requestCreateOrder >>>: ${requestCreateOrder.request}");
        print("requestCreateOrder_statusCode >>>:  ${requestCreateOrder.statusCode}");
        print("jsonCreateOrder_error >>>:  $jsonCreateOrder");
        return false;
      }
    }
  }
}
