// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased_product.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPurchasedProductCollection on Isar {
  IsarCollection<PurchasedProduct> get purchasedProducts => this.collection();
}

const PurchasedProductSchema = CollectionSchema(
  name: r'PurchasedProduct',
  id: -2475949293380043588,
  properties: {
    r'productId': PropertySchema(
      id: 0,
      name: r'productId',
      type: IsarType.string,
    ),
  },

  estimateSize: _purchasedProductEstimateSize,
  serialize: _purchasedProductSerialize,
  deserialize: _purchasedProductDeserialize,
  deserializeProp: _purchasedProductDeserializeProp,
  idName: r'id',
  indexes: {
    r'productId': IndexSchema(
      id: 5580769080710688203,
      name: r'productId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'productId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _purchasedProductGetId,
  getLinks: _purchasedProductGetLinks,
  attach: _purchasedProductAttach,
  version: '3.3.2',
);

int _purchasedProductEstimateSize(
  PurchasedProduct object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.productId.length * 3;
  return bytesCount;
}

void _purchasedProductSerialize(
  PurchasedProduct object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.productId);
}

PurchasedProduct _purchasedProductDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PurchasedProduct(productId: reader.readString(offsets[0]));
  object.id = id;
  return object;
}

P _purchasedProductDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _purchasedProductGetId(PurchasedProduct object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _purchasedProductGetLinks(PurchasedProduct object) {
  return [];
}

void _purchasedProductAttach(
  IsarCollection<dynamic> col,
  Id id,
  PurchasedProduct object,
) {
  object.id = id;
}

extension PurchasedProductByIndex on IsarCollection<PurchasedProduct> {
  Future<PurchasedProduct?> getByProductId(String productId) {
    return getByIndex(r'productId', [productId]);
  }

  PurchasedProduct? getByProductIdSync(String productId) {
    return getByIndexSync(r'productId', [productId]);
  }

  Future<bool> deleteByProductId(String productId) {
    return deleteByIndex(r'productId', [productId]);
  }

  bool deleteByProductIdSync(String productId) {
    return deleteByIndexSync(r'productId', [productId]);
  }

  Future<List<PurchasedProduct?>> getAllByProductId(
    List<String> productIdValues,
  ) {
    final values = productIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'productId', values);
  }

  List<PurchasedProduct?> getAllByProductIdSync(List<String> productIdValues) {
    final values = productIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'productId', values);
  }

  Future<int> deleteAllByProductId(List<String> productIdValues) {
    final values = productIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'productId', values);
  }

  int deleteAllByProductIdSync(List<String> productIdValues) {
    final values = productIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'productId', values);
  }

  Future<Id> putByProductId(PurchasedProduct object) {
    return putByIndex(r'productId', object);
  }

  Id putByProductIdSync(PurchasedProduct object, {bool saveLinks = true}) {
    return putByIndexSync(r'productId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByProductId(List<PurchasedProduct> objects) {
    return putAllByIndex(r'productId', objects);
  }

  List<Id> putAllByProductIdSync(
    List<PurchasedProduct> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'productId', objects, saveLinks: saveLinks);
  }
}

extension PurchasedProductQueryWhereSort
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QWhere> {
  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PurchasedProductQueryWhere
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QWhereClause> {
  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause>
  productIdEqualTo(String productId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'productId', value: [productId]),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterWhereClause>
  productIdNotEqualTo(String productId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'productId',
                lower: [],
                upper: [productId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'productId',
                lower: [productId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'productId',
                lower: [productId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'productId',
                lower: [],
                upper: [productId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension PurchasedProductQueryFilter
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QFilterCondition> {
  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'productId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'productId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'productId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'productId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'productId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'productId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'productId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'productId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'productId', value: ''),
      );
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterFilterCondition>
  productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'productId', value: ''),
      );
    });
  }
}

extension PurchasedProductQueryObject
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QFilterCondition> {}

extension PurchasedProductQueryLinks
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QFilterCondition> {}

extension PurchasedProductQuerySortBy
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QSortBy> {
  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterSortBy>
  sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterSortBy>
  sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }
}

extension PurchasedProductQuerySortThenBy
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QSortThenBy> {
  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterSortBy>
  thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<PurchasedProduct, PurchasedProduct, QAfterSortBy>
  thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }
}

extension PurchasedProductQueryWhereDistinct
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QDistinct> {
  QueryBuilder<PurchasedProduct, PurchasedProduct, QDistinct>
  distinctByProductId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId', caseSensitive: caseSensitive);
    });
  }
}

extension PurchasedProductQueryProperty
    on QueryBuilder<PurchasedProduct, PurchasedProduct, QQueryProperty> {
  QueryBuilder<PurchasedProduct, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PurchasedProduct, String, QQueryOperations> productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }
}
