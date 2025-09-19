import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/kpis.dart';
import '../domain/product_popularity.dart';
import '../domain/product_rating.dart';
import '../domain/branch_service.dart';
import '../domain/city_breakdown.dart';
import '../domain/timeseries_point.dart';
import '../domain/review.dart'; // asegúrate de tenerlo arriba



class DashboardsRpc {
  final SupabaseClient client;
  DashboardsRpc(this.client);

  Future<Kpis> fetchKpis(DateTime startDate, DateTime endDate) async {
    final map = await client
        .from('v_kpis_overview')
        .select()
        .maybeSingle();
    return Kpis.fromMap(map ?? const {});
  }

  Future<List<ProductPopularity>> fetchTopProducts(DateTime startDate, DateTime endDate) async {
    final data = await client
        .from('v_product_popularity')
        .select();
    final list = (data as List).cast<Map<String, dynamic>>();
    return list.map(ProductPopularity.fromMap).toList();
  }

  Future<List<ProductRating>> fetchProductRatings(DateTime startDate, DateTime endDate) async {
    final data = await client
        .from('v_product_ratings')
        .select();
    final list = (data as List).cast<Map<String, dynamic>>();
    return list.map(ProductRating.fromMap).toList();
  }

  Future<List<BranchService>> fetchBranchServices(DateTime startDate, DateTime endDate) async {
    final data = await client
        .from('v_branch_ratings')
        .select();
    final list = (data as List).cast<Map<String, dynamic>>();
    return list.map(BranchService.fromMap).toList();
  }

  Future<List<CityBreakdown>> fetchCityBreakdown(DateTime startDate, DateTime endDate) async {
    final data = await client
        .from('v_city_breakdown')
        .select();
    final list = (data as List).cast<Map<String, dynamic>>();
    return list.map(CityBreakdown.fromMap).toList();
  }

  Future<List<TimeseriesPoint>> fetchReviewsTimeseries(DateTime startDate, DateTime endDate) async {
    final data = await client
        .from('v_reviews_timeseries')
        .select();
    final list = (data as List).cast<Map<String, dynamic>>();
    return list.map(TimeseriesPoint.fromMap).toList();
  }
  
  Future<List<Review>> fetchRecentReviews() async {
  final response = await client
      .from('reviews')
      .select('comment, product_stars, service_stars, created_at')
      .order('created_at', ascending: false)
      .limit(5);

  return (response as List)
      .map((json) => Review.fromJson(json))
      .toList();  
  }
}