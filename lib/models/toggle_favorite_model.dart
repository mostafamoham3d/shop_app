class ToggleFavoriteModel {
  bool? status;
  String? message;
  ToggleFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
