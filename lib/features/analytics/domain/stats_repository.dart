import 'stats.dart';

abstract class StatsRepository {
  Future<Stats> compute();
}
