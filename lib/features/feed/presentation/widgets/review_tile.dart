import 'package:flutter/material.dart';
import '../../domain/public_review.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});
  final PublicReview review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado: nombre del producto + fecha
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    review.productName ?? 'Producto',
                    style: theme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(_fmt(review.createdAt), style: theme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),

            // Estrellas
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  i < review.rating ? Icons.star : Icons.star_border,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),

            if ((review.title ?? '').isNotEmpty) ...[
              Text(review.title!, style: theme.titleSmall),
              const SizedBox(height: 4),
            ],

            if ((review.comment ?? '').isNotEmpty)
              Text(
                review.comment!,
                style: theme.bodyMedium,
              ),
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