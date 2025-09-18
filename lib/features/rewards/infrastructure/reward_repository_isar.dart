import '../../../core/db/isar_db.dart';
import '../domain/reward.dart';
import '../domain/reward_repository.dart';
import 'reward_state_dto.dart';

class RewardRepositoryIsar implements RewardRepository {
  @override
  Future<RewardState> read() async {
    final isar = await IsarDb.instance();
    final dto = await isar.rewardStateDtos.get(1);
    if (dto == null) return RewardState.initial();
    return dto.toDomain();
  }

  @override
  Future<void> write(RewardState state) async {
    final isar = await IsarDb.instance();
    final dto = RewardStateMapper.fromDomain(state);
    await isar.writeTxn(() => isar.rewardStateDtos.put(dto));
  }
}
