import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabase_client.dart';
import '../../dashboards/infrastructure/dashboards_rpc.dart';
import '../../dashboards/domain/kpis.dart';
import '../../dashboards/domain/product_popularity.dart';
import '../../dashboards/domain/product_rating.dart';
import '../../dashboards/domain/branch_service.dart';
import '../../dashboards/domain/city_breakdown.dart';
import '../../dashboards/domain/timeseries_point.dart';
import '../../dashboards/domain/review.dart';
import 'dashboard_filters.dart';

/// Provider para el cliente RPC (infraestructura)
final dashboardsRpcProvider = Provider<DashboardsRpc>((ref) {
  return DashboardsRpc(SupabaseService.client);
});

/// KPIs principales
final kpisProvider = FutureProvider<Kpis>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  final range = ref.watch(dashboardDateRangeProvider);
  return rpc.fetchKpis(range.start, range.end);
});

/// Productos más populares
final topProductsProvider = FutureProvider<List<ProductPopularity>>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  final range = ref.watch(dashboardDateRangeProvider);
  return rpc.fetchTopProducts(range.start, range.end);
});

/// Mejores calificados
final topRatedProductsProvider =
    FutureProvider<List<ProductRating>>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  final range = ref.watch(dashboardDateRangeProvider);
  return rpc.fetchProductRatings(range.start, range.end);
});

/// Sucursales destacadas
final topBranchesProvider = FutureProvider<List<BranchService>>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  final range = ref.watch(dashboardDateRangeProvider);
  return rpc.fetchBranchServices(range.start, range.end);
});

/// Reviews por ciudad
final cityBreakdownProvider =
    FutureProvider<List<CityBreakdown>>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  final range = ref.watch(dashboardDateRangeProvider);
  return rpc.fetchCityBreakdown(range.start, range.end);
});

/// Evolución temporal de reviews
final reviewsTimeseriesProvider =
    FutureProvider<List<TimeseriesPoint>>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  final range = ref.watch(dashboardDateRangeProvider);
  return rpc.fetchReviewsTimeseries(range.start, range.end);
});

final recentReviewsProvider = FutureProvider<List<Review>>((ref) async {
  final rpc = ref.watch(dashboardsRpcProvider);
  return rpc.fetchRecentReviews();
});