// To parse this JSON data, do
//
//     final toggleCartItem = toggleCartItemFromJson(jsonString);

import 'dart:convert';

ToggleCartItem toggleCartItemFromJson(String str) =>
    ToggleCartItem.fromJson(json.decode(str));

String toggleCartItemToJson(ToggleCartItem data) => json.encode(data.toJson());

class ToggleCartItem {
  ToggleCartItem({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ToggleCartItem.fromJson(Map<String, dynamic> json) => ToggleCartItem(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.quantity,
    this.product,
  });

  int? id;
  int? quantity;
  Product? product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product!.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  int? id;
  double? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
      };
}
