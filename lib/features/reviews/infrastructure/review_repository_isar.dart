import 'package:isar/isar.dart';
import '../../../core/db/isar_db.dart';
import '../domain/review.dart';
import '../domain/review_repository.dart';
import 'review_dto.dart';

class ReviewRepositoryIsar implements ReviewRepository {
  @override
  Future<List<Review>> getAll() async {
    final isar = await IsarDb.instance();
    final list = await isar.reviewDtos.where().sortByCreatedAtDesc().findAll();
    return list.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> add(Review review) async {
    final isar = await IsarDb.instance();
    final dto = ReviewMapper.fromDomain(review);
    await isar.writeTxn(() => isar.reviewDtos.put(dto));
  }

  @override
  Future<List<Review>> byOrderId(String orderId) async {
    final isar = await IsarDb.instance();
    final list = await isar.reviewDtos.filter().orderIdEqualTo(orderId).findAll();
    return list.map((e) => e.toDomain()).toList();
  }
}
