import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as pp;
import '../../features/orders/infrastructure/order_dto.dart';
import '../../features/reviews/infrastructure/review_dto.dart';
import '../../features/rewards/infrastructure/reward_state_dto.dart';

class IsarDb {
  static Isar? _isar;

  static Future<Isar> instance() async {
    if (_isar != null) return _isar!;
    final dir = await pp.getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        OrderDtoSchema,
        ReviewDtoSchema,
        RewardStateDtoSchema,
      ],
      directory: dir.path,
      name: 'chefscore',
    );

    return _isar!;
  }
}
