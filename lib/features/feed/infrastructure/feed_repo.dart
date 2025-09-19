import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chefscore/core/utils/result.dart';
import 'package:chefscore/features/feed/domain/public_review.dart';

class FeedRepo {
  final SupabaseClient client;
  FeedRepo(this.client);

  Future<Result<List<PublicReview>>> fetchRecentReviews() async {
    try {
      final response = await client
          .from('reviews')
          .select('id, product_id, branch_id, product_stars, service_stars, comment, created_at')
          .order('created_at', ascending: false)
          .limit(20);

      final reviews = (response as List<dynamic>)
          .map((e) => PublicReview.fromMap(Map<String, dynamic>.from(e)))
          .toList();

      return Result.success(reviews);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}