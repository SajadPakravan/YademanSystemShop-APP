/// id : 876
/// name : "منبع تغذیه"
/// slug : "%d9%85%d9%86%d8%a8%d8%b9-%d8%aa%d8%ba%d8%b0%db%8c%d9%87"
/// description : "<p>منبع تغذیهمنبع منبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهمنبع تغذیهتغذیهمنبع تغذیه</p>\n"
/// short_description : "<p>تاهنقتفلاتفاا</p>\n"
/// price : "4500000"
/// regular_price : "5000000"
/// sale_price : "4500000"
/// categories : [{"id":161,"name":"منبع تغذیه","slug":"%d9%85%d9%86%d8%a8%d8%b9-%d8%aa%d8%ba%d8%b0%db%8c%d9%87"}]
/// images : [{"id": 673,"src": "https://sajadpakravan.ir/wp-content/uploads/2019/07/poasjcbjhasbhbchwer-300x300-1.png","name": "poasjcbjhasbhbchwer-300&#215;300"}]
/// attributes : [{"id":0,"name":"لثا","position":0,"visible":true,"variation":false,"options":["اثاثا"]},{"id":0,"name":"اثاثا","position":1,"visible":true,"variation":false,"options":["ااقفت"]}]
/// default_attributes : []

class ProductModel {
  int? _id;
  String? _name;
  String? _slug;
  String? _description;
  String? _shortDescription;
  String? _price;
  String? _regularPrice;
  String? _salePrice;
  List<Categories>? _categories;
  List<Images>? _images;
  List<Attributes>? _attributes;

  int? get id => _id;

  String? get name => _name;

  String? get slug => _slug;

  String? get description => _description;

  String? get shortDescription => _shortDescription;

  String? get price => _price;

  String? get regularPrice => _regularPrice;

  String? get salePrice => _salePrice;

  List<Categories>? get categories => _categories;

  List<Images>? get images => _images;

  List<Attributes>? get attributes => _attributes;

  ProductModel({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? shortDescription,
    String? price,
    String? regularPrice,
    String? salePrice,
    List<Categories>? categories,
    List<Images>? images,
    List<Attributes>? attributes,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _description = description;
    _shortDescription = shortDescription;
    _price = price;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _categories = categories;
    _images = images;
    _attributes = attributes;
  }

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _shortDescription = json['short_description'];
    _price = json['price'];
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['short_description'] = _shortDescription;
    map['price'] = _price;
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 0
/// name : "لثا"
/// options : ["اثاثا"]

class Attributes {
  Attributes({
    int? id,
    String? name,
    List<String>? options,
  }) {
    _id = id;
    _name = name;
    _options = options;
  }

  Attributes.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _options = json['options'] != null ? json['options'].cast<String>() : [];
  }

  int? _id;
  String? _name;
  List<String>? _options;

  int? get id => _id;

  String? get name => _name;

  List<String>? get options => _options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['options'] = _options;
    return map;
  }
}

/// id : 673
/// src : "https://sajadpakravan.ir/wp-content/uploads/2019/07/poasjcbjhasbhbchwer-300x300-1.png"
/// name : "poasjcbjhasbhbchwer-300&#215;300"

class Images {
  Images({
    int? id,
    String? src,
    String? name,}){
    _id = id;
    _src = src;
    _name = name;
  }

  Images.fromJson(dynamic json) {
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

/// id : 161
/// name : "منبع تغذیه"
/// slug : "%d9%85%d9%86%d8%a8%d8%b9-%d8%aa%d8%ba%d8%b0%db%8c%d9%87"

class Categories {
  Categories({
    int? id,
    String? name,
    String? slug,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }

  int? _id;
  String? _name;
  String? _slug;

  int? get id => _id;

  String? get name => _name;

  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }
}
