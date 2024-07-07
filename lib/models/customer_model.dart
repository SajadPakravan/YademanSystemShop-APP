class CustomerModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? avatarUrl;
  Billing? billing;
  Shipping? shipping;

  CustomerModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.avatarUrl,
    this.billing,
    this.shipping,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
    billing = json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['role'] = role;
    data['username'] = username;
    data['avatar_url'] = avatarUrl;
    if (billing != null) data['billing'] = billing!.toJson();
    if (shipping != null) data['shipping'] = shipping!.toJson();
    return data;
  }
}

class Billing {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? address1;
  String? address2;
  String? postcode;

  Billing({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.country,
    this.state,
    this.city,
    this.address1,
    this.address2,
    this.postcode,
  });

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['postcode'] = postcode;
    return data;
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? address1;
  String? address2;
  String? postcode;

  Shipping({this.firstName, this.lastName, this.phone, this.country, this.state, this.city, this.address1, this.address2, this.postcode});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['postcode'] = postcode;
    return data;
  }
}
