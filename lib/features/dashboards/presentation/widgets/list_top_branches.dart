import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/dashboards_providers.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../domain/branch_service.dart';

/// Lista de sucursales top según las reviews.
class ListTopBranches extends ConsumerWidget {
  const ListTopBranches({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(topBranchesProvider);

    return AsyncValueView<List<BranchService>>(
      value: branchesAsync,
      builder: (branches) {
        if (branches.isEmpty) {
          return const Center(child: Text('No hay sucursales aún'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: branches.map((b) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.store, size: 30, color: Colors.blueGrey),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.branchName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${b.totalReviews} reseñas',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber.shade600, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          b.avgServiceStars?.toStringAsFixed(1) ?? '0.0',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}