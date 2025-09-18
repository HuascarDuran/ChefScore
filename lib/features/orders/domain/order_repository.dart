import 'order.dart';

abstract class OrderRepository {
  Future<List<Order>> getAll();
  Future<void> upsert(Order order);
  Future<Order?> getById(String id);
}
