import '../domain/stats.dart';
import '../domain/stats_repository.dart';

class StatsService {
  final StatsRepository repo;
  StatsService(this.repo);
  Future<Stats> snapshot() => repo.compute();
}
