import 'review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getAll();
  Future<void> add(Review review);
  Future<List<Review>> byOrderId(String orderId);
}
