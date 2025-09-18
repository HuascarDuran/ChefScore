import '../../../core/utils/id.dart';
import '../../orders/application/order_service.dart';
import '../../rewards/application/reward_service.dart';
import '../domain/review.dart';
import '../domain/review_repository.dart';

class ReviewService {
  final ReviewRepository repo;
  final OrderService orders;
  final RewardService rewards;
  ReviewService(this.repo, this.orders, this.rewards);

  /// Regla "solo si pidió": debe existir un Order no reseñado.
  Future<bool> canReview(String orderId) async {
    final order = await orders.repo.getById(orderId);
    if (order == null) return false;
    final existing = await repo.byOrderId(orderId);
    return existing.isEmpty; // sin reseña previa
  }

  Future<Review> submitReview({
    required String orderId,
    required int productStars,
    required int serviceStars,
    String? comment,
  }) async {
    if (!(await canReview(orderId))) {
      throw Exception('Este pedido ya fue reseñado o no existe.');
    }
    final review = Review(
      id: newId('rev'),
      orderId: orderId,
      productStars: productStars,
      serviceStars: serviceStars,
      comment: comment,
      createdAt: DateTime.now(),
    );
    await repo.add(review);
    await orders.markOrderReviewed(orderId);

    // Reglas de puntos: +10 por reseña, +2 extra si ambas >=4 estrellas
    var points = 10;
    if (productStars >= 4 && serviceStars >= 4) points += 2;
    await rewards.addPoints(points);

    // Si el pedido es elegible, genera un código de descuento guardado
    final ord = await orders.repo.getById(orderId);
    if (ord != null && orders.eligibleForDiscount(ord)) {
      await rewards.maybeGenerateDiscountCodeForOrder(orderId);
    }

    return review;
  }
}
