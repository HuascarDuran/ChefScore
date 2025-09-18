import '../domain/order.dart';
import '../domain/order_repository.dart';
import '../../../core/utils/id.dart';

class OrderService {
  final OrderRepository repo;
  OrderService(this.repo);

  Future<List<Order>> listOrders() => repo.getAll();

  Future<Order> createOrder({required List<String> items}) async {
    final order = Order(id: newId('ord'), createdAt: DateTime.now(), items: items);
    await repo.upsert(order);
    return order;
  }

  Future<void> markOrderReviewed(String orderId) async {
    final order = await repo.getById(orderId);
    if (order == null) return;
    await repo.upsert(order.markReviewed());
  }

  /// Regla base para descuentos: si el pedido fue "hoy", retorna true.
  bool eligibleForDiscount(Order order) {
    final now = DateTime.now();
    final sameDay = now.year == order.createdAt.year &&
        now.month == order.createdAt.month &&
        now.day == order.createdAt.day;
    return sameDay;
  }
}
