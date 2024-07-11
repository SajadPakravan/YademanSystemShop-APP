class ProductModel {
  ProductModel({
    int? id,
    String? name,
    String? description,
    String? shortDescription,
    String? price,
    String? regularPrice,
    bool? onSale,
    List<ProductCategory>? categories,
    List<ProductImage>? images,
    List<Attribute>? attributes,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _shortDescription = shortDescription;
    _price = price;
    _regularPrice = regularPrice;
    _categories = categories;
    _images = images;
    _attributes = attributes;
  }

  int? _id;
  String? _name;
  String? _description;
  String? _shortDescription;
  String? _price;
  String? _regularPrice;
  bool? _onSale;
  List<ProductCategory>? _categories;
  List<ProductImage>? _images;
  List<Attribute>? _attributes;

  int? get id => _id;

  String? get name => _name;

  String? get description => _description;

  String? get shortDescription => _shortDescription;

  String? get price => _price;

  String? get regularPrice => _regularPrice;

  bool? get onSale => _onSale;

  List<ProductCategory>? get categories => _categories;

  List<ProductImage>? get images => _images;

  List<Attribute>? get attributes => _attributes;

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _shortDescription = json['short_description'];
    _price = json['price'];
    _regularPrice = json['regular_price'];
    _onSale = json['on_sale'];
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) => _categories?.add(ProductCategory.fromJson(v)));
    }
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) => _images?.add(ProductImage.fromJson(v)));
    }
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) => _attributes?.add(Attribute.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['short_description'] = _shortDescription;
    map['price'] = _price;
    map['regular_price'] = _regularPrice;
    map['on_sale'] = _onSale;
    if (_categories != null) map['categories'] = _categories?.map((v) => v.toJson()).toList();
    if (_images != null) map['images'] = _images?.map((v) => v.toJson()).toList();
    if (_attributes != null) map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    return map;
  }
}

class ProductCategory {
  ProductCategory({int? id, String? name}) {
    _id = id;
    _name = name;
  }

  int? _id;
  String? _name;

  int? get id => _id;

  String? get name => _name;

  ProductCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

class ProductImage {
  ProductImage({int? id, String? src}) {
    _id = id;
    _src = src;
  }

  int? _id;
  String? _src;

  int? get id => _id;

  String? get src => _src;

  ProductImage.fromJson(dynamic json) {
    _id = json['id'];
    _src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['src'] = _src;
    return map;
  }
}

class Attribute {
  Attribute({String? name, List<String>? options}) {
    _name = name;
    _options = options;
  }

  String? _name;
  List<String>? _options;

  String? get name => _name;

  List<String>? get options => _options;

  Attribute.fromJson(dynamic json) {
    _name = json['name'];
    _options = json['options'] != null ? json['options'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['options'] = _options;
    return map;
  }
}
