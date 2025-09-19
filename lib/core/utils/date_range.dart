


enum DateRange {
  last7Days,
  last30Days,
  last90Days,
}

extension DateRangeX on DateRange {
  String get label {
    switch (this) {
      case DateRange.last7Days:
        return 'Últimos 7 días';
      case DateRange.last30Days:
        return 'Últimos 30 días';
      case DateRange.last90Days:
        return 'Últimos 90 días';
    }
  }

  DateTime get start {
    final now = DateTime.now();
    switch (this) {
      case DateRange.last7Days:
        return now.subtract(const Duration(days: 7));
      case DateRange.last30Days:
        return now.subtract(const Duration(days: 30));
      case DateRange.last90Days:
        return now.subtract(const Duration(days: 90));
    }
  }

  DateTime get end => DateTime.now();
}