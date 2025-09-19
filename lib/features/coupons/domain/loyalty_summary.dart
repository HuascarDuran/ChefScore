class LoyaltySummary {
  final int points;

  const LoyaltySummary({required this.points});

  factory LoyaltySummary.fromCount(int sum) => LoyaltySummary(points: sum);
}