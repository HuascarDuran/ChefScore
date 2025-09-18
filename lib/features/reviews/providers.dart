import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di.dart';
import '../reviews/domain/review_repository.dart';
import '../reviews/infrastructure/review_repository_isar.dart';
import '../reviews/application/review_service.dart';
import '../orders/providers.dart';
import '../rewards/providers.dart';

final reviewRepoProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryIsar();
});


final reviewServiceProvider = Provider<ReviewService>((ref) {
  final repo = ref.watch(reviewRepoProvider);
  final orders = ref.watch(orderServiceProvider);
  final rewards = ref.watch(rewardServiceProvider);
  return ReviewService(repo, orders, rewards);
});

final allReviewsProvider = FutureProvider((ref) async {
  return ref.watch(reviewRepoProvider).getAll();
});
