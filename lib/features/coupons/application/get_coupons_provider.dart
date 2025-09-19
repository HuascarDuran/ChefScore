import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/device_id.dart';
import '../data/coupons_repo.dart';
import '../domain/coupon_model.dart';
import '../domain/loyalty_summary.dart';

final couponsRepoProvider = Provider<CouponsRepo>((ref) => CouponsRepo());

/// ID del dispositivo (reutiliza tu servicio existente).
final deviceIdFutureProvider = FutureProvider<String>((ref) async {
  return DeviceId.get();
});

/// Puntos del usuario.
final loyaltyPointsProvider = FutureProvider<LoyaltySummary>((ref) async {
  final deviceId = await ref.watch(deviceIdFutureProvider.future);
  final repo = ref.watch(couponsRepoProvider);
  return repo.getLoyaltySummary(deviceId);
});

/// Cupones activos del usuario.
final myCouponsProvider = FutureProvider<List<Coupon>>((ref) async {
  final deviceId = await ref.watch(deviceIdFutureProvider.future);
  final repo = ref.watch(couponsRepoProvider);
  return repo.getActiveCoupons(deviceId);
});

/// Para forzar refresco desde la UI.
final refreshCouponsProvider = Provider<void Function()>((ref) {
  return () {
    ref.invalidate(loyaltyPointsProvider);
    ref.invalidate(myCouponsProvider);
  };
});