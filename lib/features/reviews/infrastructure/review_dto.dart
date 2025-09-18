import 'package:isar/isar.dart';
import '../domain/review.dart';

part 'review_dto.g.dart';

@collection
class ReviewDto {
  Id idIsar = Isar.autoIncrement;
  late String id;
  @Index()
  late String orderId;
  late int productStars;
  late int serviceStars;
  String? comment;
  late DateTime createdAt;
}

extension ReviewMapper on ReviewDto {
  Review toDomain() => Review(
    id: id,
    orderId: orderId,
    productStars: productStars,
    serviceStars: serviceStars,
    comment: comment,
    createdAt: createdAt,
  );
  static ReviewDto fromDomain(Review r) {
    final dto = ReviewDto()
      ..id = r.id
      ..orderId = r.orderId
      ..productStars = r.productStars
      ..serviceStars = r.serviceStars
      ..comment = r.comment
      ..createdAt = r.createdAt;
    return dto;
  }
}
