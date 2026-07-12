class CartProductModel {
  int? id;
  String? title;
  num? price;
  int? quantity;
  num? total;
  num? discountPercentage;
  num? discountedTotal;
  String? thumbnail;

  CartProductModel({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.total,
    this.discountPercentage,
    this.discountedTotal,
    this.thumbnail,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    discountPercentage = json['discountPercentage'];
    discountedTotal = json['discountedTotal'];
    thumbnail = json['thumbnail'];
  }
}

class CartModel {
  int? id;
  List<CartProductModel> products;
  num? total;
  num? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  CartModel({
    this.id,
    this.products = const [],
    this.total,
    this.discountedTotal,
    this.userId,
    this.totalProducts,
    this.totalQuantity,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : products = (json['products'] as List)
            .map((e) => CartProductModel.fromJson(e))
            .toList() {
    id = json['id'];
    total = json['total'];
    discountedTotal = json['discountedTotal'];
    userId = json['userId'];
    totalProducts = json['totalProducts'];
    totalQuantity = json['totalQuantity'];
  }

  factory CartModel.empty() => CartModel(products: []);
}