import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/coupon_model.dart';
import '../domain/loyalty_summary.dart';

class CouponsRepo {
  CouponsRepo({SupabaseClient? client}) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  /// Suma los puntos del device en loyalty_ledger.
  Future<LoyaltySummary> getLoyaltySummary(String deviceId) async {
    final resp = await _client
        .from('loyalty_ledger')
        .select('delta_points')
        .eq('device_id', deviceId);

    final list = (resp as List)
        .map((e) => (e['delta_points'] as num).toInt())
        .toList();

    final total = list.isEmpty ? 0 : list.reduce((a, b) => a + b);
    return LoyaltySummary(points: total);
  }

  /// Retorna cupones activos y no usados del device.
  Future<List<Coupon>> getActiveCoupons(String deviceId) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();

    final resp = await _client
        .from('coupons')
        .select()
        .eq('device_id', deviceId)
        .eq('is_active', true)
        .isFilter('redeemed_at', null) // no canjeados
        .or('expires_at.is.null,expires_at.gt.$nowIso') // sin expirar o null
        .order('issued_at', ascending: false);

    final list = (resp as List)
        .map((e) => Coupon.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return list;
  }
}