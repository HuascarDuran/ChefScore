import 'package:isar/isar.dart';
import '../../orders/domain/order.dart';

part 'order_dto.g.dart';

@collection
class OrderDto {
  Id idIsar = Isar.autoIncrement; // PK interna
  late String id;                  // id de dominio
  late DateTime createdAt;
  late List<String> items;
  @Index()
  bool reviewed = false;
}

extension OrderMapper on OrderDto {
  Order toDomain() => Order(
    id: id,
    createdAt: createdAt,
    items: List<String>.from(items),
    reviewed: reviewed,
  );
  static OrderDto fromDomain(Order o) {
    final dto = OrderDto()
      ..id = o.id
      ..createdAt = o.createdAt
      ..items = o.items
      ..reviewed = o.reviewed;
    return dto;
  }
}
