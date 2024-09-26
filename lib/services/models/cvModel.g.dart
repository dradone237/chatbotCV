// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCvModelCollection on Isar {
  IsarCollection<CvModel> get cvModels => this.collection();
}

const CvModelSchema = CollectionSchema(
  name: r'CvModel',
  id: -1001148557805136486,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'planCarriers': PropertySchema(
      id: 1,
      name: r'planCarriers',
      type: IsarType.objectList,
      target: r'PlanCarrier',
    )
  },
  estimateSize: _cvModelEstimateSize,
  serialize: _cvModelSerialize,
  deserialize: _cvModelDeserialize,
  deserializeProp: _cvModelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'PlanCarrier': PlanCarrierSchema},
  getId: _cvModelGetId,
  getLinks: _cvModelGetLinks,
  attach: _cvModelAttach,
  version: '3.1.0+1',
);

int _cvModelEstimateSize(
  CvModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  {
    final list = object.planCarriers;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[PlanCarrier]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              PlanCarrierSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _cvModelSerialize(
  CvModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeObjectList<PlanCarrier>(
    offsets[1],
    allOffsets,
    PlanCarrierSchema.serialize,
    object.planCarriers,
  );
}

CvModel _cvModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CvModel(
    planCarriers: reader.readObjectList<PlanCarrier>(
      offsets[1],
      PlanCarrierSchema.deserialize,
      allOffsets,
      PlanCarrier(),
    ),
  );
  object.id = reader.readString(offsets[0]);
  return object;
}

P _cvModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<PlanCarrier>(
        offset,
        PlanCarrierSchema.deserialize,
        allOffsets,
        PlanCarrier(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cvModelGetId(CvModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cvModelGetLinks(CvModel object) {
  return [];
}

void _cvModelAttach(IsarCollection<dynamic> col, Id id, CvModel object) {}

extension CvModelQueryWhereSort on QueryBuilder<CvModel, CvModel, QWhere> {
  QueryBuilder<CvModel, CvModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CvModelQueryWhere on QueryBuilder<CvModel, CvModel, QWhereClause> {
  QueryBuilder<CvModel, CvModel, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CvModelQueryFilter
    on QueryBuilder<CvModel, CvModel, QFilterCondition> {
  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> planCarriersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planCarriers',
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition>
      planCarriersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planCarriers',
      ));
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition>
      planCarriersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'planCarriers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> planCarriersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'planCarriers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition>
      planCarriersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'planCarriers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition>
      planCarriersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'planCarriers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition>
      planCarriersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'planCarriers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterFilterCondition>
      planCarriersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'planCarriers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CvModelQueryObject
    on QueryBuilder<CvModel, CvModel, QFilterCondition> {
  QueryBuilder<CvModel, CvModel, QAfterFilterCondition> planCarriersElement(
      FilterQuery<PlanCarrier> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'planCarriers');
    });
  }
}

extension CvModelQueryLinks
    on QueryBuilder<CvModel, CvModel, QFilterCondition> {}

extension CvModelQuerySortBy on QueryBuilder<CvModel, CvModel, QSortBy> {
  QueryBuilder<CvModel, CvModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CvModelQuerySortThenBy
    on QueryBuilder<CvModel, CvModel, QSortThenBy> {
  QueryBuilder<CvModel, CvModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CvModel, CvModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension CvModelQueryWhereDistinct
    on QueryBuilder<CvModel, CvModel, QDistinct> {
  QueryBuilder<CvModel, CvModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }
}

extension CvModelQueryProperty
    on QueryBuilder<CvModel, CvModel, QQueryProperty> {
  QueryBuilder<CvModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CvModel, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CvModel, List<PlanCarrier>?, QQueryOperations>
      planCarriersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planCarriers');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PlanCarrierSchema = Schema(
  name: r'PlanCarrier',
  id: 165992699181044126,
  properties: {
    r'centreFormation': PropertySchema(
      id: 0,
      name: r'centreFormation',
      type: IsarType.stringList,
    ),
    r'certification': PropertySchema(
      id: 1,
      name: r'certification',
      type: IsarType.stringList,
    ),
    r'competenceRequises': PropertySchema(
      id: 2,
      name: r'competenceRequises',
      type: IsarType.stringList,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'poste': PropertySchema(
      id: 4,
      name: r'poste',
      type: IsarType.string,
    )
  },
  estimateSize: _planCarrierEstimateSize,
  serialize: _planCarrierSerialize,
  deserialize: _planCarrierDeserialize,
  deserializeProp: _planCarrierDeserializeProp,
);

int _planCarrierEstimateSize(
  PlanCarrier object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.centreFormation;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.certification;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.competenceRequises;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.poste;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _planCarrierSerialize(
  PlanCarrier object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.centreFormation);
  writer.writeStringList(offsets[1], object.certification);
  writer.writeStringList(offsets[2], object.competenceRequises);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.poste);
}

PlanCarrier _planCarrierDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlanCarrier(
    centreFormation: reader.readStringList(offsets[0]),
    certification: reader.readStringList(offsets[1]),
    competenceRequises: reader.readStringList(offsets[2]),
    description: reader.readStringOrNull(offsets[3]),
    poste: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _planCarrierDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PlanCarrierQueryFilter
    on QueryBuilder<PlanCarrier, PlanCarrier, QFilterCondition> {
  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'centreFormation',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'centreFormation',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centreFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'centreFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'centreFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'centreFormation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'centreFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'centreFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'centreFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'centreFormation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centreFormation',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'centreFormation',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'centreFormation',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'centreFormation',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'centreFormation',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'centreFormation',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'centreFormation',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      centreFormationLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'centreFormation',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'certification',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'certification',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'certification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'certification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'certification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'certification',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'certification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'certification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'certification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'certification',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'certification',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'certification',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'certification',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'certification',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'certification',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'certification',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'certification',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      certificationLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'certification',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'competenceRequises',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'competenceRequises',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'competenceRequises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'competenceRequises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'competenceRequises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'competenceRequises',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'competenceRequises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'competenceRequises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'competenceRequises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'competenceRequises',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'competenceRequises',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'competenceRequises',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competenceRequises',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competenceRequises',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competenceRequises',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competenceRequises',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competenceRequises',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      competenceRequisesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competenceRequises',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poste',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      posteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poste',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      posteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'poste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'poste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'poste',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'poste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'poste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'poste',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'poste',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition> posteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poste',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanCarrier, PlanCarrier, QAfterFilterCondition>
      posteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'poste',
        value: '',
      ));
    });
  }
}

extension PlanCarrierQueryObject
    on QueryBuilder<PlanCarrier, PlanCarrier, QFilterCondition> {}
