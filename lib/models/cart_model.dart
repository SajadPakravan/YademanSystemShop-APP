const String tableCart = 'carts';

class CartFields {
  static final List<String> values = [
    id,
    productId,
    productImage,
    productName,
    productPrice,
    productQuantity,
    productTotalPrice,
  ];

  static const String id = 'id';
  static const String productId = 'product_id';
  static const String productImage = 'product_image';
  static const String productName = 'product_name';
  static const String productPrice = 'product_price';
  static const String productQuantity = 'product_quantity';
  static const String productTotalPrice = 'product_totalPrice';
}

class Cart {
  final int? id;
  final int? productId;
  final String? productImage;
  final String? productName;
  final int? productPrice;
  final int? productQuantity;
  final int? productTotalPrice;

  const Cart({
    this.id,
    this.productId,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productQuantity,
    this.productTotalPrice,
  });

  Cart copy({
    int? id,
    int? productId,
    String? productImage,
    String? productName,
    int? productPrice,
    int? productQuantity,
    int? productTotalPrice,
  }) =>
      Cart(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productImage: productImage ?? this.productImage,
        productName: productName ?? this.productName,
        productPrice: productPrice ?? this.productPrice,
        productQuantity: productQuantity ?? this.productQuantity,
        productTotalPrice: productTotalPrice ?? this.productTotalPrice,
      );

  static Cart fromJson(Map<String, Object?> json) => Cart(
        id: json[CartFields.id] as int,
        productId: json[CartFields.productId] as int,
        productImage: json[CartFields.productImage] as String,
        productName: json[CartFields.productName] as String,
        productPrice: json[CartFields.productPrice] as int,
        productQuantity: json[CartFields.productQuantity] as int,
        productTotalPrice: json[CartFields.productTotalPrice] as int,
      );

  Map<String, Object?> toJson() => {
        CartFields.id: id,
        CartFields.productId: productId,
        CartFields.productImage: productImage,
        CartFields.productName: productName,
        CartFields.productPrice: productPrice,
        CartFields.productQuantity: productQuantity,
        CartFields.productTotalPrice: productTotalPrice,
      };
}
