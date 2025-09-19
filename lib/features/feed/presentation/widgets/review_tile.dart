import 'package:flutter/material.dart';
import '../../domain/public_review.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});
  final PublicReview review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final product = review.productName ?? 'Producto';
    final branch = review.branchName ?? 'Sucursal';
    final date = _fmt(review.createdAt);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado: producto + fecha
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    product,
                    style: theme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(date, style: theme.bodySmall),
              ],
            ),
            const SizedBox(height: 4),
            Text(branch, style: theme.bodySmall),

            const SizedBox(height: 8),
            // Estrellas de producto y servicio (responsivo)
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _Stars(label: 'Producto', value: review.productStars),
                _Stars(label: 'Servicio', value: review.serviceStars),
              ],
            ),

            if ((review.comment ?? '').isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                review.comment!,
                style: theme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime d) {
    final local = d.toLocal();
    final yyyy = local.year.toString().padLeft(4, '0');
    final mm = local.month.toString().padLeft(2, '0');
    final dd = local.day.toString().padLeft(2, '0');
    return '$yyyy-$mm-$dd';
  }
}

class _Stars extends StatelessWidget {
  const _Stars({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label:', style: theme.labelMedium),
        const SizedBox(width: 6),
        Row(
          children: List.generate(
            5,
            (i) => Icon(
              i < value ? Icons.star : Icons.star_border,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}