import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/dashboards_providers.dart';

class RecentReviewsCard extends ConsumerWidget {
  const RecentReviewsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentReviews = ref.watch(recentReviewsProvider);

    return recentReviews.when(
      data: (reviews) => Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Últimas Reseñas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...reviews.map((r) => ListTile(
                    title: Text(
                      r.comment?.isNotEmpty == true
                          ? r.comment!
                          : 'Sin comentario',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    subtitle: Text(
                      'Producto ⭐ ${r.productStars} · Servicio ⭐ ${r.serviceStars}',
                    ),
                    trailing: Text(
                      '${r.createdAt.day}/${r.createdAt.month}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )),
            ],
          ),
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }
}