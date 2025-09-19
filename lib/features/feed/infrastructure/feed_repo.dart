import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/public_review.dart';

class FeedRepo {
  FeedRepo({SupabaseClient? client}) : _client = client ?? Supabase.instance.client;
  final SupabaseClient _client;

  /// Trae TODAS las reviews del usuario (por device_id), ordenadas por fecha desc.
  Future<List<PublicReview>> getMyReviews(String deviceId) async {
    // Ajusta los campos según tu tabla "reviews".
    // Si tienes una vista que ya devuelve product_name, mantenla.
    final resp = await _client
        .from('reviews')
        .select('id, device_id, product_id, product_name, rating, title, comment, created_at')
        .eq('device_id', deviceId)
        .order('created_at', ascending: false);

    final list = (resp as List)
        .map((e) => PublicReview.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return list;
  }
}