import 'cart_item.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final OrderStatus status;
  final String deliveryAddress;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.deliveryAddress,
  });
}
