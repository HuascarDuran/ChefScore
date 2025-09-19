

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import '../../../core/services/supabase_client.dart';
import '../infrastructure/feed_repo.dart';
import '../domain/public_review.dart';
import '../../../core/utils/result.dart';

// Fallback: proveedor local del cliente de Supabase si no existe en core
final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

// Repo provider (inyecta el SupabaseClient)
final feedRepoProvider = Provider<FeedRepo>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return FeedRepo(client);
});

/// FutureProvider que expone directamente `List<PublicReview>` para la UI.
/// Internamente desenvuelve el `Result` del repositorio y lanza una excepción
/// si vino `Failure`, para que `AsyncValue` muestre error.
final feedProvider = FutureProvider<List<PublicReview>>((ref) async {
  final repo = ref.watch(feedRepoProvider);
  final result = await repo.fetchRecentReviews();

  if (result is Success<List<PublicReview>>) {
    return result.value;
  }
  if (result is Failure<List<PublicReview>>) {
    throw Exception(result.error);
  }
  // Caso imposible, pero por seguridad
  throw Exception('Unknown result');
});