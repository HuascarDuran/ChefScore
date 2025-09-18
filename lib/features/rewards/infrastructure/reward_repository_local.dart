import '../../../core/local_storage/local_storage.dart';
import '../domain/reward.dart';
import '../domain/reward_repository.dart';

class RewardRepositoryLocal implements RewardRepository {
  static const _key = 'rewards_box_v1';
  final LocalStorage storage;
  RewardRepositoryLocal(this.storage);

  @override
  Future<RewardState> read() async {
    final json = await storage.readJson(_key);
    if (json == null) return RewardState.initial();
    return RewardState.fromJson(json);
  }

  @override
  Future<void> write(RewardState state) => storage.writeJson(_key, state.toJson());
}
