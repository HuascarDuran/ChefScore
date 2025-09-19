import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/device_id.dart';
import '../domain/new_review.dart';
import '../infrastructure/review_repo.dart';

class CreateReviewController extends StateNotifier<AsyncValue<void>> {
  final ReviewRepo _repo;

  CreateReviewController(this._repo) : super(const AsyncData(null));

  Future<void> submit(NewReview review) async {
    state = const AsyncLoading();
    try {
      final deviceId = await DeviceId.get();
      await _repo.insertReview(review.toMap(deviceId));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

/// Provider del controlador
final createReviewControllerProvider =
    StateNotifierProvider<CreateReviewController, AsyncValue<void>>((ref) {
  final repo = ref.watch(reviewRepoProvider);
  return CreateReviewController(repo);
});