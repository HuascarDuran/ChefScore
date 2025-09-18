import '../../../core/local_storage/local_storage.dart';
import '../domain/review.dart';
import '../domain/review_repository.dart';

class ReviewRepositoryLocal implements ReviewRepository {
  static const _key = 'reviews_box_v1';
  final LocalStorage storage;
  ReviewRepositoryLocal(this.storage);

  Future<Map<String, dynamic>> _readAllMap() async =>
      (await storage.readJson(_key)) ?? {'reviews': []};

  Future<void> _writeAll(List<Review> reviews) =>
      storage.writeJson(_key, {'reviews': reviews.map((e) => e.toJson()).toList()});

  @override
  Future<List<Review>> getAll() async {
    final map = await _readAllMap();
    final list = (map['reviews'] as List? ?? []);
    return list.map((e) => Review.fromJson(Map<String, dynamic>.from(e))).toList()
      ..sort((a,b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> add(Review review) async {
    final current = await getAll();
    current.add(review);
    await _writeAll(current);
  }

  @override
  Future<List<Review>> byOrderId(String orderId) async {
    final all = await getAll();
    return all.where((r) => r.orderId == orderId).toList();
  }
}
