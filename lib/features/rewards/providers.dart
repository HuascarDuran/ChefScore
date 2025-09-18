import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di.dart';
import 'domain/reward_repository.dart';
import 'infrastructure/reward_repository_isar.dart';
import 'application/reward_service.dart';

final rewardRepoProvider = Provider<RewardRepository>((ref) {
  return RewardRepositoryIsar();
});

final rewardServiceProvider = Provider<RewardService>((ref) {
  final repo = ref.watch(rewardRepoProvider);
  return RewardService(repo);
});

final pointsProvider = FutureProvider<int>((ref) async {
  return ref.watch(rewardServiceProvider).getPoints();
});

final discountCodesProvider = FutureProvider<List<String>>((ref) async {
  return ref.watch(rewardServiceProvider).getDiscounts();
});
