// lib/features/orders/infrastructure/order_repository_isar.dart
import 'package:isar/isar.dart';
import '../../../core/db/isar_db.dart';
import '../domain/order.dart';
import '../domain/order_repository.dart';
import 'order_dto.dart';

class OrderRepositoryIsar implements OrderRepository {
  @override
  Future<List<Order>> getAll() async {
    final isar = await IsarDb.instance();
    final list = await isar.orderDtos.where().sortByCreatedAtDesc().findAll();
    return list.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Order?> getById(String id) async {
    final isar = await IsarDb.instance();
    final dto = await isar.orderDtos.filter().idEqualTo(id).findFirst();
    return dto?.toDomain();
  }

  @override
  Future<void> upsert(Order order) async {
    final isar = await IsarDb.instance();
    final existing = await isar.orderDtos.filter().idEqualTo(order.id).findFirst();
    final dto = OrderMapper.fromDomain(order)
      ..idIsar = existing?.idIsar ?? Isar.autoIncrement;
    await isar.writeTxn(() => isar.orderDtos.put(dto));
  }
}
