// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competenceModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompetenceModelCollection on Isar {
  IsarCollection<CompetenceModel> get competenceModels => this.collection();
}

const CompetenceModelSchema = CollectionSchema(
  name: r'CompetenceModel',
  id: 176340449112835464,
  properties: {
    r'competences': PropertySchema(
      id: 0,
      name: r'competences',
      type: IsarType.objectList,
      target: r'Competence',
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    )
  },
  estimateSize: _competenceModelEstimateSize,
  serialize: _competenceModelSerialize,
  deserialize: _competenceModelDeserialize,
  deserializeProp: _competenceModelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Competence': CompetenceSchema},
  getId: _competenceModelGetId,
  getLinks: _competenceModelGetLinks,
  attach: _competenceModelAttach,
  version: '3.1.0+1',
);

int _competenceModelEstimateSize(
  CompetenceModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.competences;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Competence]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CompetenceSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.id.length * 3;
  return bytesCount;
}

void _competenceModelSerialize(
  CompetenceModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Competence>(
    offsets[0],
    allOffsets,
    CompetenceSchema.serialize,
    object.competences,
  );
  writer.writeString(offsets[1], object.id);
}

CompetenceModel _competenceModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompetenceModel(
    competences: reader.readObjectList<Competence>(
      offsets[0],
      CompetenceSchema.deserialize,
      allOffsets,
      Competence(),
    ),
  );
  object.id = reader.readString(offsets[1]);
  return object;
}

P _competenceModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Competence>(
        offset,
        CompetenceSchema.deserialize,
        allOffsets,
        Competence(),
      )) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _competenceModelGetId(CompetenceModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _competenceModelGetLinks(CompetenceModel object) {
  return [];
}

void _competenceModelAttach(
    IsarCollection<dynamic> col, Id id, CompetenceModel object) {}

extension CompetenceModelQueryWhereSort
    on QueryBuilder<CompetenceModel, CompetenceModel, QWhere> {
  QueryBuilder<CompetenceModel, CompetenceModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompetenceModelQueryWhere
    on QueryBuilder<CompetenceModel, CompetenceModel, QWhereClause> {
  QueryBuilder<CompetenceModel, CompetenceModel, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterWhereClause>
      isarIdBetween(
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

extension CompetenceModelQueryFilter
    on QueryBuilder<CompetenceModel, CompetenceModel, QFilterCondition> {
  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'competences',
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'competences',
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'competences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      isarIdLessThan(
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

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      isarIdBetween(
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
}

extension CompetenceModelQueryObject
    on QueryBuilder<CompetenceModel, CompetenceModel, QFilterCondition> {
  QueryBuilder<CompetenceModel, CompetenceModel, QAfterFilterCondition>
      competencesElement(FilterQuery<Competence> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'competences');
    });
  }
}

extension CompetenceModelQueryLinks
    on QueryBuilder<CompetenceModel, CompetenceModel, QFilterCondition> {}

extension CompetenceModelQuerySortBy
    on QueryBuilder<CompetenceModel, CompetenceModel, QSortBy> {
  QueryBuilder<CompetenceModel, CompetenceModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CompetenceModelQuerySortThenBy
    on QueryBuilder<CompetenceModel, CompetenceModel, QSortThenBy> {
  QueryBuilder<CompetenceModel, CompetenceModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CompetenceModel, CompetenceModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension CompetenceModelQueryWhereDistinct
    on QueryBuilder<CompetenceModel, CompetenceModel, QDistinct> {
  QueryBuilder<CompetenceModel, CompetenceModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }
}

extension CompetenceModelQueryProperty
    on QueryBuilder<CompetenceModel, CompetenceModel, QQueryProperty> {
  QueryBuilder<CompetenceModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CompetenceModel, List<Competence>?, QQueryOperations>
      competencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'competences');
    });
  }

  QueryBuilder<CompetenceModel, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CompetenceSchema = Schema(
  name: r'Competence',
  id: -7319254395399131896,
  properties: {
    r'justification': PropertySchema(
      id: 0,
      name: r'justification',
      type: IsarType.string,
    ),
    r'lieuFormation': PropertySchema(
      id: 1,
      name: r'lieuFormation',
      type: IsarType.stringList,
    ),
    r'nomCompetence': PropertySchema(
      id: 2,
      name: r'nomCompetence',
      type: IsarType.string,
    )
  },
  estimateSize: _competenceEstimateSize,
  serialize: _competenceSerialize,
  deserialize: _competenceDeserialize,
  deserializeProp: _competenceDeserializeProp,
);

int _competenceEstimateSize(
  Competence object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.justification;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.lieuFormation;
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
    final value = object.nomCompetence;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _competenceSerialize(
  Competence object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.justification);
  writer.writeStringList(offsets[1], object.lieuFormation);
  writer.writeString(offsets[2], object.nomCompetence);
}

Competence _competenceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Competence(
    justification: reader.readStringOrNull(offsets[0]),
    lieuFormation: reader.readStringList(offsets[1]),
    nomCompetence: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _competenceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CompetenceQueryFilter
    on QueryBuilder<Competence, Competence, QFilterCondition> {
  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'justification',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'justification',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'justification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'justification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'justification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'justification',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'justification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'justification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'justification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'justification',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'justification',
        value: '',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      justificationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'justification',
        value: '',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lieuFormation',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lieuFormation',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lieuFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lieuFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lieuFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lieuFormation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lieuFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lieuFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lieuFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lieuFormation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lieuFormation',
        value: '',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lieuFormation',
        value: '',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lieuFormation',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lieuFormation',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lieuFormation',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lieuFormation',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lieuFormation',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      lieuFormationLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lieuFormation',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomCompetence',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomCompetence',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomCompetence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomCompetence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomCompetence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomCompetence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomCompetence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomCompetence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomCompetence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomCompetence',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomCompetence',
        value: '',
      ));
    });
  }

  QueryBuilder<Competence, Competence, QAfterFilterCondition>
      nomCompetenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomCompetence',
        value: '',
      ));
    });
  }
}

extension CompetenceQueryObject
    on QueryBuilder<Competence, Competence, QFilterCondition> {}
