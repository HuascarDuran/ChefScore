import 'package:isar/isar.dart';
import '../../features/orders/infrastructure/order_dto.dart';
import '../../features/reviews/infrastructure/review_dto.dart';
import '../../core/db/isar_db.dart';
import '../utils/id.dart';

class DbSeeder {
  static const _seedKey = 'seed_v1_done';

  static Future<void> run() async {
    final isar = await IsarDb.instance();
    // Si ya hay pedidos, asumimos seeded
    final count = await isar.orderDtos.count();
    if (count > 0) return;

    final menu = <String>[
      'Whopper', 'Whopper Doble', 'King de Pollo',
      'Rodeo Burger', 'Long Chicken', 'Papas King',
      'Onion Rings', 'Coca-Cola 500ml', 'Helado Cono',
    ];

    final now = DateTime.now();
    final orders = List.generate(8, (i) {
      final items = <String>[
        menu[i % menu.length],
        if (i.isEven) 'Papas King',
        if (i % 3 == 0) 'Coca-Cola 500ml',
      ];
      final dto = OrderDto()
        ..id = newId('ord')
        ..createdAt = now.subtract(Duration(hours: 8 - i))
        ..items = items
        ..reviewed = false;
      return dto;
    });

    await isar.writeTxn(() async {
      await isar.orderDtos.putAll(orders);
    });

    // agrega un par de reseñas iniciales para stats
    final firstOrder = orders.first;
    final review1 = ReviewDto()
      ..id = newId('rev')
      ..orderId = firstOrder.id
      ..productStars = 5
      ..serviceStars = 4
      ..comment = 'Rico y rápido'
      ..createdAt = now.subtract(const Duration(hours: 6));

    final secondOrder = orders[1];
    final review2 = ReviewDto()
      ..id = newId('rev')
      ..orderId = secondOrder.id
      ..productStars = 3
      ..serviceStars = 4
      ..comment = 'Podría estar más caliente'
      ..createdAt = now.subtract(const Duration(hours: 5));

    await isar.writeTxn(() async {
      await isar.reviewDtos.putAll([review1, review2]);
      // marcamos reviewed en esos pedidos
      final o1 = await isar.orderDtos.filter().idEqualTo(firstOrder.id).findFirst();
      final o2 = await isar.orderDtos.filter().idEqualTo(secondOrder.id).findFirst();
      if (o1 != null) { o1.reviewed = true; await isar.orderDtos.put(o1); }
      if (o2 != null) { o2.reviewed = true; await isar.orderDtos.put(o2); }
    });
  }
}
