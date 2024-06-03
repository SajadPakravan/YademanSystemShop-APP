class ProductCategoryModel {
  ProductCategoryModel({
    int? id,
    String? name,
    int? parent,
    ProductCategoryImage? image,
    int? count,
    bool? select,
  }) {
    _id = id;
    _name = name;
    _parent = parent;
    _image = image;
    _count = count;
    _select = select;
  }

  int? _id;
  String? _name;
  int? _parent;
  ProductCategoryImage? _image;
  int? _count;
  bool? _select;

  int? get id => _id;

  String? get name => _name;

  int? get parent => _parent;

  ProductCategoryImage? get image => _image;

  int? get count => _count;

  bool? get getSelect => _select;

  set setSelect(bool value) => _select = value;

  ProductCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parent = json['parent'];
    _image = json['image'] != null ? ProductCategoryImage.fromJson(json['image']) : null;
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent'] = _parent;
    if (_image != null) map['image'] = _image?.toJson();
    map['count'] = _count;
    return map;
  }
}

class ProductCategoryImage {
  ProductCategoryImage({String? src}) {
    _src = src;
  }

  ProductCategoryImage.fromJson(dynamic json) {
    _src = json['src'];
  }

  String? _src;

  String? get src => _src;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = _src;
    return map;
  }
}
