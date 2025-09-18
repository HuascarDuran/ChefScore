import 'package:flutter/foundation.dart';
import '../../../core/local_storage/local_storage.dart';
import '../domain/order.dart';
import '../domain/order_repository.dart';

class OrderRepositoryLocal implements OrderRepository {
  static const _key = 'orders_box_v1';
  final LocalStorage storage;
  OrderRepositoryLocal(this.storage);

  Future<Map<String, dynamic>> _readAllMap() async =>
      (await storage.readJson(_key)) ?? {'orders': []};

  Future<void> _writeAll(List<Order> orders) => storage
      .writeJson(_key, {'orders': orders.map((e) => e.toJson()).toList()});

  @override
  Future<List<Order>> getAll() async {
    final map = await _readAllMap();
    final list = (map['orders'] as List? ?? []);
    return list
        .map((e) => Order.fromJson(Map<String, dynamic>.from(e)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Order?> getById(String id) async {
    final list = await getAll();
    for (final o in list) {
      if (o.id == id) return o;
    }
    return null;
  }

  @override
  Future<void> upsert(Order order) async {
    final current = await getAll();
    final idx = current.indexWhere((o) => o.id == order.id);
    if (idx >= 0) {
      current[idx] = order;
    } else {
      current.add(order);
    }
    await _writeAll(current);
    if (kDebugMode) print('[OrderRepositoryLocal] upsert ${order.id}');
  }
}
