import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../orders/providers.dart';
import '../providers.dart';
import 'review_form_page.dart';
import '../../rewards/providers.dart';

class ReviewsPage extends ConsumerWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reseñar pedidos')),
      body: ordersAsync.when(
        data: (orders) {
          final pending = orders.where((o) => !o.reviewed).toList();
          if (pending.isEmpty) {
            return const Center(
                child: Text('No hay pedidos pendientes de reseña.'));
          }
          return ListView.separated(
            itemCount: pending.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final o = pending[i];
              return ListTile(
                title: Text(o.items.join(' · ')),
                subtitle: Text('Creado: ${o.createdAt}'),
                trailing: FilledButton(
                  onPressed: () async {
                    final ok = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewFormPage(orderId: o.id),
                      ),
                    );
                    if (ok == true) {
                      ref.invalidate(ordersListProvider);
                      ref.invalidate(allReviewsProvider);
                      ref.invalidate(pointsProvider);
                    }
                  },
                  child: const Text('Reseñar'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
