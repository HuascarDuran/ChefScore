import 'reward.dart';

abstract class RewardRepository {
  Future<RewardState> read();
  Future<void> write(RewardState state);
}
