import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/public_review.dart';

class FeedRepo {
  FeedRepo({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  /// Trae TODAS las reseñas del usuario (por device_id), con nombres
  /// de producto y sucursal, ordenadas por fecha desc.
  Future<List<PublicReview>> getMyReviews(String deviceId) async {
    // Notación de Supabase para traer columnas relacionadas (via FK):
    // products(name), branches(name)
    final resp = await _client
        .from('reviews')
        .select(
          'id, device_id, product_id, branch_id,'
          'product_stars, service_stars, comment, created_at,'
          'products(name), branches(name)',
        )
        .eq('device_id', deviceId)
        .order('created_at', ascending: false);

    final list = (resp as List)
        .map((e) => PublicReview.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return list;
  }
}