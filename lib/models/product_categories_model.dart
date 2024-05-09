/// id : 150
/// name : "اسپیکر"
/// parent : 0
/// description : ""
/// image : {"id":836,"src":"https://sajadpakravan.ir/wp-content/uploads/2021/11/ComputerShop_catalogs.png","name":"ComputerShop_catalogs"}
/// count : 7

class ProductCategoryModel {
  ProductCategoryModel({
    int? id,
    String? name,
    int? parent,
    String? description,
    ProductCategoryImage? image,
    int? count,
    bool? select,
  }) {
    _id = id;
    _name = name;
    _parent = parent;
    _description = description;
    _image = image;
    _count = count;
    _select = select;
  }

  int? _id;
  String? _name;
  int? _parent;
  String? _description;
  ProductCategoryImage? _image;
  int? _count;
  bool? _select;

  int? get id => _id;

  String? get name => _name;

  int? get parent => _parent;

  String? get description => _description;

  ProductCategoryImage? get image => _image;

  int? get count => _count;

  bool? get getSelect => _select;

  set setSelect (bool value) {
    _select = value;
  }

  ProductCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parent = json['parent'];
    _description = json['description'];
    _image = json['image'] != null ? ProductCategoryImage.fromJson(json['image']) : null;
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent'] = _parent;
    map['description'] = _description;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['count'] = _count;
    return map;
  }
}

/// id : 836
/// src : "https://sajadpakravan.ir/wp-content/uploads/2021/11/ComputerShop_catalogs.png"
/// name : "ComputerShop_catalogs"

class ProductCategoryImage {
  ProductCategoryImage({
    int? id,
    String? src,
    String? name,
  }) {
    _id = id;
    _src = src;
    _name = name;
  }

  ProductCategoryImage.fromJson(dynamic json) {
    _id = json['id'];
    _src = json['src'];
    _name = json['name'];
  }

  int? _id;
  String? _src;
  String? _name;

  int? get id => _id;

  String? get src => _src;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['src'] = _src;
    map['name'] = _name;
    return map;
  }
}
