import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di.dart';
import 'domain/order_repository.dart';
import 'infrastructure/order_repository_isar.dart';
import 'application/order_service.dart';

final orderRepoProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryIsar();
});

final orderServiceProvider = Provider<OrderService>((ref) {
  final repo = ref.watch(orderRepoProvider);
  return OrderService(repo);
});

final ordersListProvider = FutureProvider((ref) async {
  return ref.watch(orderServiceProvider).listOrders();
});
