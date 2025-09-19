import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/dashboards_providers.dart';
import '../../domain/kpis.dart';
import '../../domain/product_rating.dart';
import '../../../../core/widgets/async_value_view.dart';

class KpiCards extends ConsumerWidget {
  const KpiCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpisAsync = ref.watch(kpisProvider);

    return AsyncValueView<Kpis>(
      value: kpisAsync,
      builder: (kpis) {
        final theme = Theme.of(context).textTheme;
        final topProducts = ref.watch(topProductsProvider).valueOrNull ?? [];
        final topProductName = topProducts.isNotEmpty ? topProducts.first.productName : '-';
        final topProductRating = topProducts.isNotEmpty ? kpis.avgProductStars.toStringAsFixed(1) : '-';
        final items = [
          _KpiItem(
            label: 'Reseñas',
            value: kpis.totalReviews.toString(),
            icon: Icons.rate_review,
          ),
          _KpiItem(
            label: 'Mejor Producto',
            value: '$topProductName • ${topProductRating}★',
            icon: Icons.emoji_food_beverage,
          ),
          _KpiItem(
            label: 'Sucursales',
            value: kpis.branchesCount.toString(),
            icon: Icons.store,
          ),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            final crossAxisCount = isWide ? 4 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 130,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length >= 5 ? 5 : items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (item.icon != null)
                              Icon(item.icon, size: 20, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(item.label, style: theme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            item.value,
                            style: theme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _KpiItem {
  final String label;
  final String value;
  final IconData? icon; // Nuevo campo opcional
  const _KpiItem({required this.label, required this.value, this.icon});
}