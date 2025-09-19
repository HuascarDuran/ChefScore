import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final String id;
  final String deviceId;
  final String code;
  final int percentOff;
  final DateTime issuedAt;
  final DateTime? redeemedAt;
  final DateTime? expiresAt;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Coupon({
    required this.id,
    required this.deviceId,
    required this.code,
    required this.percentOff,
    required this.issuedAt,
    this.redeemedAt,
    this.expiresAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'] as String,
      deviceId: map['device_id'] as String,
      code: map['code'] as String,
      percentOff: (map['percent_off'] as num).toInt(),
      issuedAt: DateTime.parse(map['issued_at'] as String),
      redeemedAt: map['redeemed_at'] != null ? DateTime.parse(map['redeemed_at'] as String) : null,
      expiresAt: map['expires_at'] != null ? DateTime.parse(map['expires_at'] as String) : null,
      isActive: map['is_active'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  @override
  List<Object?> get props => [id, code, percentOff, isActive, redeemedAt, expiresAt];
}