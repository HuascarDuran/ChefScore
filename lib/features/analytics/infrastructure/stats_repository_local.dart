import '../../reviews/domain/review_repository.dart';
import '../domain/stats.dart';
import '../domain/stats_repository.dart';

class StatsRepositoryLocal implements StatsRepository {
  final ReviewRepository reviews;
  StatsRepositoryLocal(this.reviews);

  @override
  Future<Stats> compute() async {
    final all = await reviews.getAll();
    if (all.isEmpty) return Stats(totalReviews: 0, avgProduct: 0, avgService: 0);
    final p = all.map((r) => r.productStars).reduce((a,b)=>a+b) / all.length;
    final s = all.map((r) => r.serviceStars).reduce((a,b)=>a+b) / all.length;
    return Stats(totalReviews: all.length, avgProduct: p, avgService: s);
  }
}
