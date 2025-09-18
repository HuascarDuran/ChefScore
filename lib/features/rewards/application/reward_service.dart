import '../domain/reward_repository.dart';
import '../../../core/utils/id.dart';

class RewardService {
  final RewardRepository repo;
  RewardService(this.repo);

  Future<int> getPoints() async => (await repo.read()).points;

  Future<void> addPoints(int delta) async {
    final s = await repo.read();
    await repo.write(s.copyWith(points: s.points + delta));
  }

  Future<void> redeem(int cost) async {
    final s = await repo.read();
    if (s.points < cost) throw Exception('Puntos insuficientes');
    await repo.write(s.copyWith(points: s.points - cost));
  }

  Future<List<String>> getDiscounts() async => (await repo.read()).discountCodes;

  Future<void> maybeGenerateDiscountCodeForOrder(String orderId) async {
    final s = await repo.read();
    final code = 'DSC-${orderId.substring(0, 6).toUpperCase()}-${newId().substring(0,4)}';
    final list = List<String>.from(s.discountCodes)..add(code);
    await repo.write(s.copyWith(discountCodes: list));
  }
}
