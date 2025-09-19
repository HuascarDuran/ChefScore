import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/device_id.dart';
import '../domain/public_review.dart';
import '../infrastructure/feed_repo.dart';

final feedRepoProvider = Provider<FeedRepo>((ref) => FeedRepo());

/// ID del dispositivo usando tu servicio ya existente
final deviceIdFutureProvider = FutureProvider<String>((ref) async {
  return DeviceId.get();
});

/// Reseñas del usuario (todas por device_id)
final myReviewsProvider =
    FutureProvider.autoDispose<List<PublicReview>>((ref) async {
  final repo = ref.watch(feedRepoProvider);
  final deviceId = await ref.watch(deviceIdFutureProvider.future);
  return repo.getMyReviews(deviceId);
});

/// Para refrescar desde la UI (invalidate)
final refreshMyReviewsProvider = Provider<void Function()>((ref) {
  return () => ref.invalidate(myReviewsProvider);
});