

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../application/dashboards_providers.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../domain/timeseries_point.dart';

/// Gráfico de líneas que muestra evolución de reseñas en el tiempo.
class ReviewsTimeseriesChart extends ConsumerWidget {
  const ReviewsTimeseriesChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeseriesAsync = ref.watch(reviewsTimeseriesProvider);

    return AsyncValueView<List<TimeseriesPoint>>(
      value: timeseriesAsync,
      builder: (points) {
        if (points.isEmpty) {
          return const Center(child: Text('No hay datos de reseñas aún'));
        }

        final spots = points
            .map(
              (p) => FlSpot(
                p.date.millisecondsSinceEpoch.toDouble(),
                p.count.toDouble(),
              ),
            )
            .toList();

        return SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blueAccent,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}