import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/dashboards_providers.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../domain/city_breakdown.dart';

/// Tabla con desglose de reseñas y ratings por ciudad.
class CityTable extends ConsumerWidget {
  const CityTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsync = ref.watch(cityBreakdownProvider);

    return AsyncValueView<List<CityBreakdown>>(
      value: citiesAsync,
      builder: (cities) {
        if (cities.isEmpty) {
          return const Center(child: Text('No hay datos por ciudad aún'));
        }

        return DataTable(
          columns: const [
            DataColumn(label: Text('Ciudad')),
            DataColumn(label: Text('Reseñas')),
            DataColumn(label: Text('Promedio')),
          ],
          rows: cities
              .map(
                (c) => DataRow(
                  cells: [
                    DataCell(Text(c.city)),
                    DataCell(Text(c.totalReviews.toString())),
                    DataCell(Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text((c.avgServiceStars ?? 0.0).toStringAsFixed(1)),
                      ],
                    )),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}