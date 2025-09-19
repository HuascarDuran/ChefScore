import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Filtros posibles para los dashboards (ej: últimos 7, 30, 90 días)
enum DashboardDateFilter {
  last7Days,
  last30Days,
  last90Days,
}

extension DashboardDateFilterX on DashboardDateFilter {
  DateTimeRange toMaterialRange() {
    final now = DateTime.now();
    switch (this) {
      case DashboardDateFilter.last7Days:
        return DateTimeRange(start: now.subtract(const Duration(days: 7)), end: now);
      case DashboardDateFilter.last30Days:
        return DateTimeRange(start: now.subtract(const Duration(days: 30)), end: now);
      case DashboardDateFilter.last90Days:
        return DateTimeRange(start: now.subtract(const Duration(days: 90)), end: now);
    }
  }

  String get label {
    switch (this) {
      case DashboardDateFilter.last7Days:
        return 'Últimos 7 días';
      case DashboardDateFilter.last30Days:
        return 'Últimos 30 días';
      case DashboardDateFilter.last90Days:
        return 'Últimos 90 días';
    }
  }
}

/// Provider global que mantiene el filtro seleccionado

final dashboardDateFilterProvider =
    StateProvider<DashboardDateFilter>((ref) => DashboardDateFilter.last7Days);

/// Provider que expone directamente el rango de fechas calculado
final dashboardDateRangeProvider = Provider<DateTimeRange>((ref) {
  final filter = ref.watch(dashboardDateFilterProvider);
  return filter.toMaterialRange();
});
