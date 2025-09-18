import 'package:isar/isar.dart';
import '../domain/reward.dart';

part 'reward_state_dto.g.dart';

@collection
class RewardStateDto {
  // Única fila (guardamos todo el estado en un registro)
  Id idIsar = 1;
  int points = 0;
  List<String> discountCodes = [];
}

extension RewardStateMapper on RewardStateDto {
  RewardState toDomain() => RewardState(points: points, discountCodes: List<String>.from(discountCodes));
  static RewardStateDto fromDomain(RewardState s) {
    final dto = RewardStateDto()
      ..idIsar = 1
      ..points = s.points
      ..discountCodes = List<String>.from(s.discountCodes);
    return dto;
  }
}
