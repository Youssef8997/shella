import 'package:sixam_mart/features/order/domain/models/order_model.dart';

class OrderRequestModel {
  final int id;
  final int orderId;
  final DeliveryMan deliveryMan;
  final double price;

  OrderRequestModel(
      {required this.id,
      required this.orderId,
      required this.deliveryMan,
      required this.price});
  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
        id: json["id"],
        deliveryMan: DeliveryMan.fromJson(json["delivery_man"]),
        orderId: json["order_id"],
        price: double.parse(json["price"].toString()));
  }
}
