import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../reviews/providers.dart';
import 'application/stats_service.dart';
import 'domain/stats_repository.dart';
import 'infrastructure/stats_repository_local.dart';

final statsRepoProvider = Provider<StatsRepository>((ref) {
  final revRepo = ref.watch(reviewRepoProvider);
  return StatsRepositoryLocal(revRepo);
});

final statsServiceProvider = Provider<StatsService>((ref) {
  final repo = ref.watch(statsRepoProvider);
  return StatsService(repo);
});

// Ejemplo: un snapshot para futuros dashboards
final statsSnapshotProvider = FutureProvider((ref) async {
  return ref.watch(statsServiceProvider).snapshot();
});
