import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_client.dart';
import '../domain/new_review.dart';
import '../domain/my_review.dart';

class ReviewRepo {
  final SupabaseClient client;
  ReviewRepo(this.client);

  Future<void> insertReview(Map<String, dynamic> data) async {
    await client.from('reviews').insert(data);
  }

  Future<List<MyReview>> getMyReviews(String deviceId) async {
    final data = await client
        .from('reviews')
        .select('id, product_id, branch_id, product_stars, service_stars, comment, created_at')
        .eq('device_id', deviceId)
        .order('created_at', ascending: false);

    return (data as List)
        .map((row) => MyReview.fromMap(Map<String, dynamic>.from(row)))
        .toList();
  }
}

/// Provider del repositorio
final reviewRepoProvider = Provider<ReviewRepo>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return ReviewRepo(client);
});