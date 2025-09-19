

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/my_review.dart';
import '../infrastructure/review_repo.dart';
import '../../../core/services/device_id.dart';


/// Proveedor que obtiene las reseñas del dispositivo actual.
final myReviewsProvider = FutureProvider.autoDispose<List<MyReview>>((ref) async {
  final repo = ref.watch(reviewRepoProvider);
  final deviceId = await DeviceId.get();
  return repo.getMyReviews(deviceId);
});

/// Helper para forzar la recarga desde la UI, por ejemplo después de crear una reseña.
final refreshMyReviewsProvider = Provider<void Function()>((ref) {
  return () => ref.invalidate(myReviewsProvider);
});