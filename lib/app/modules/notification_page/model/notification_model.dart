class NotificationModel {
  int? id;
  int? shopId;
  String? title;
  String? message;
  String? createdAt;

  NotificationModel({
    this.id,
    this.shopId,
    this.title,
    this.message,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      shopId: json['shop_id'],
      title: json['title'],
      message: json['message'],
      createdAt: json['created_at'],
    );
  }
}
