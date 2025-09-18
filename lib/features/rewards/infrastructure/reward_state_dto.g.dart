// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_state_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRewardStateDtoCollection on Isar {
  IsarCollection<RewardStateDto> get rewardStateDtos => this.collection();
}

const RewardStateDtoSchema = CollectionSchema(
  name: r'RewardStateDto',
  id: -2228295469862257944,
  properties: {
    r'discountCodes': PropertySchema(
      id: 0,
      name: r'discountCodes',
      type: IsarType.stringList,
    ),
    r'points': PropertySchema(
      id: 1,
      name: r'points',
      type: IsarType.long,
    )
  },
  estimateSize: _rewardStateDtoEstimateSize,
  serialize: _rewardStateDtoSerialize,
  deserialize: _rewardStateDtoDeserialize,
  deserializeProp: _rewardStateDtoDeserializeProp,
  idName: r'idIsar',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _rewardStateDtoGetId,
  getLinks: _rewardStateDtoGetLinks,
  attach: _rewardStateDtoAttach,
  version: '3.1.0+1',
);

int _rewardStateDtoEstimateSize(
  RewardStateDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.discountCodes.length * 3;
  {
    for (var i = 0; i < object.discountCodes.length; i++) {
      final value = object.discountCodes[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _rewardStateDtoSerialize(
  RewardStateDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.discountCodes);
  writer.writeLong(offsets[1], object.points);
}

RewardStateDto _rewardStateDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RewardStateDto();
  object.discountCodes = reader.readStringList(offsets[0]) ?? [];
  object.idIsar = id;
  object.points = reader.readLong(offsets[1]);
  return object;
}

P _rewardStateDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rewardStateDtoGetId(RewardStateDto object) {
  return object.idIsar;
}

List<IsarLinkBase<dynamic>> _rewardStateDtoGetLinks(RewardStateDto object) {
  return [];
}

void _rewardStateDtoAttach(
    IsarCollection<dynamic> col, Id id, RewardStateDto object) {
  object.idIsar = id;
}

extension RewardStateDtoQueryWhereSort
    on QueryBuilder<RewardStateDto, RewardStateDto, QWhere> {
  QueryBuilder<RewardStateDto, RewardStateDto, QAfterWhere> anyIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RewardStateDtoQueryWhere
    on QueryBuilder<RewardStateDto, RewardStateDto, QWhereClause> {
  QueryBuilder<RewardStateDto, RewardStateDto, QAfterWhereClause> idIsarEqualTo(
      Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idIsar,
        upper: idIsar,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterWhereClause>
      idIsarNotEqualTo(Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterWhereClause>
      idIsarGreaterThan(Id idIsar, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idIsar, includeLower: include),
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterWhereClause>
      idIsarLessThan(Id idIsar, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idIsar, includeUpper: include),
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterWhereClause> idIsarBetween(
    Id lowerIdIsar,
    Id upperIdIsar, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdIsar,
        includeLower: includeLower,
        upper: upperIdIsar,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RewardStateDtoQueryFilter
    on QueryBuilder<RewardStateDto, RewardStateDto, QFilterCondition> {
  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountCodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discountCodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discountCodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discountCodes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'discountCodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'discountCodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'discountCodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'discountCodes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountCodes',
        value: '',
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'discountCodes',
        value: '',
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'discountCodes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'discountCodes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'discountCodes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'discountCodes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'discountCodes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      discountCodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'discountCodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      idIsarEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      idIsarGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      idIsarLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      idIsarBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idIsar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      pointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      pointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      pointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterFilterCondition>
      pointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'points',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RewardStateDtoQueryObject
    on QueryBuilder<RewardStateDto, RewardStateDto, QFilterCondition> {}

extension RewardStateDtoQueryLinks
    on QueryBuilder<RewardStateDto, RewardStateDto, QFilterCondition> {}

extension RewardStateDtoQuerySortBy
    on QueryBuilder<RewardStateDto, RewardStateDto, QSortBy> {
  QueryBuilder<RewardStateDto, RewardStateDto, QAfterSortBy> sortByPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.asc);
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterSortBy>
      sortByPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.desc);
    });
  }
}

extension RewardStateDtoQuerySortThenBy
    on QueryBuilder<RewardStateDto, RewardStateDto, QSortThenBy> {
  QueryBuilder<RewardStateDto, RewardStateDto, QAfterSortBy> thenByIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.asc);
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterSortBy>
      thenByIdIsarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.desc);
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterSortBy> thenByPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.asc);
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QAfterSortBy>
      thenByPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.desc);
    });
  }
}

extension RewardStateDtoQueryWhereDistinct
    on QueryBuilder<RewardStateDto, RewardStateDto, QDistinct> {
  QueryBuilder<RewardStateDto, RewardStateDto, QDistinct>
      distinctByDiscountCodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discountCodes');
    });
  }

  QueryBuilder<RewardStateDto, RewardStateDto, QDistinct> distinctByPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'points');
    });
  }
}

extension RewardStateDtoQueryProperty
    on QueryBuilder<RewardStateDto, RewardStateDto, QQueryProperty> {
  QueryBuilder<RewardStateDto, int, QQueryOperations> idIsarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idIsar');
    });
  }

  QueryBuilder<RewardStateDto, List<String>, QQueryOperations>
      discountCodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discountCodes');
    });
  }

  QueryBuilder<RewardStateDto, int, QQueryOperations> pointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'points');
    });
  }
}
