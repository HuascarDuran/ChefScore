

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/my_reviews_providers.dart';

class MyReviewsScreen extends ConsumerWidget {
  const MyReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myReviewsAsync = ref.watch(myReviewsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reseñas'),
      ),
      body: myReviewsAsync.when(
        data: (reviews) {
          if (reviews.isEmpty) {
            return const Center(child: Text('No tienes reseñas aún.'));
          }
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ListTile(
                title: Text('Producto #${review.productId} • Sucursal #${review.branchId}'),
                subtitle: Text(review.comment ?? ''),
                trailing: Text('${review.stars}★'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}