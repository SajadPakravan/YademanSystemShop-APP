class UserFields {
  static const String tblName = "user";
  static const String id = 'id';
  static const String token = 'token';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String email = 'email';
  static const String avatar = 'avatar';

  List<String> allFields = [id, token, name, phone, email, avatar];
}

class User {
  final int? id;
  final String? token;
  final String? name;
  final String? phone;
  final String? email;
  final String? avatar;

  const User({this.id, this.token, this.name, this.phone, this.email, this.avatar});

  User copy({int? id, String? token, String? name, String? phone, String? email, String? avatar}) => User(
        id: id ?? this.id,
        token: token ?? this.token,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        token: json['token'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        avatar: json['avatar'],
      );

  Map<String, dynamic> toJson() {
    return {
      UserFields.id: id,
      UserFields.token: token,
      UserFields.name: name,
      UserFields.phone: phone,
      UserFields.email: email,
      UserFields.avatar: avatar,
    };
  }
}
