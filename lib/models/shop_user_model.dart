class ShopModel {
  bool? status;
  String? message;
  ShopUserModel? data;

  ShopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ShopUserModel.fromJson(json['data']) : null;
  }
}

class ShopUserModel {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;
  int? credit;
  int? points;

  ShopUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
    credit = json['credit'];
    points = json['points'];
  }
}
