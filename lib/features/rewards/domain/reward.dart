class RewardState {
  final int points;
  final List<String> discountCodes; // simples strings generados localmente

  RewardState({required this.points, required this.discountCodes});

  factory RewardState.initial() => RewardState(points: 0, discountCodes: []);

  factory RewardState.fromJson(Map<String, dynamic> json) => RewardState(
    points: json['points'] as int? ?? 0,
    discountCodes: (json['discountCodes'] as List? ?? []).map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    'points': points,
    'discountCodes': discountCodes,
  };

  RewardState copyWith({int? points, List<String>? discountCodes}) =>
      RewardState(
        points: points ?? this.points,
        discountCodes: discountCodes ?? this.discountCodes,
      );
}
