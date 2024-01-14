
import 'package:flutter/widgets.dart';
import 'package:ijshopflutter/services/models/filter_model.dart';
import 'package:ijshopflutter/services/models/user.dart';
import 'package:ijshopflutter/services/network/connectionStatus.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// flutter pub run build_runner build

class IsarService {
  late Future<Isar> db;
  ConnectionStatusSingleton? connectionStatusSingleton =
      ConnectionStatusSingleton();
  ValueNotifier<bool> isServerConnected = ValueNotifier(false);

  IsarService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [
          UserSchema,
         
        ],
        directory: dir.path,
        inspector: true,
      );

      connectionStatusSingleton?.isServerConnected.addListener(() async {
        if (connectionStatusSingleton?.isServerConnected.value == true) {
          // List<Info> unSyncedInfos =
          //     await isar.infos.where().filter().isSyncEqualTo(false).findAll();
          // List<Paper> unSyncedPaper =
          //     await isar.papers.where().filter().isSyncEqualTo(false).findAll();
          // List<Transaction> unSyncedTrans = await isar.transactions
          //     .where()
          //     .filter()
          //     .isSyncEqualTo(false)
          //     .findAll();
          // List<Procedure> unSyncedProc = await isar.procedures
          //     .where()
          //     .filter()
          //     .isSyncEqualTo(false)
          //     .findAll();

          // try {
          //   if (unSyncedInfos.isNotEmpty) {
          //     for (Info element in unSyncedInfos) {
          //       // appel de l'api pour la suppresion
          //     }

          //     await saveAll<Info>(unSyncedInfos);
          //   }
          // } catch (e) {
          //   print('Erreur lors de la synchronisation des données : $e');
          // }
        }
      });
      return isar;
    }

    return Future.value(Isar.getInstance());
  }

  void getStatusConnection() {
    isServerConnected = connectionStatusSingleton!.isServerConnected;
  }

  Future<int> save<T>(T input) async {
    final isar = await db;
    final resol = isar.collection<T>();
    final result = await isar
        .writeTxn<int>(() async => await resol.put(input))
        .catchError((onError) {
      print(onError.toString());
      throw Exception(onError);
    });
    return result;
  }

  Future<List<int>> saveAll<T>(List<T> elements) async {
    final isar = await db;
    final resol = isar.collection<T>();
    final result = await isar
        .writeTxn<List<int>>(() async => await resol.putAll(elements))
        .catchError((onError) {
      print(onError.toString());
      throw Exception(onError);
    });
    return result;
  }

  Future<List<dynamic>?> query<T>(
      {List<FilterModel>? where,
      offset = 1,
      limit = 6,
      String? or = 'and'}) async {
    List<WhereClause>? whereClause = [];
    List<FilterCondition>? listFilter = [];
    List<SortProperty>? listSort = [
      const SortProperty(
        property: 'createdAt',
        sort: Sort.desc,
      )
    ];
    if (where != null) {
      for (final criteria in where) {
        if (criteria.type == FilterType.FILTER) {
          listFilter.add(_applyFilter(criteria));
        } else if (criteria.type == FilterType.SORT) {
          listSort.add(_applySort(criteria.field));
        }
      }
    }
    final isar = await db;
    final resol = isar.collection<T>();
    final result = await resol
        .buildQuery(
          whereClauses: whereClause,
          filter: FilterGroup.and(listFilter),
          sortBy: listSort,
          offset: offset * limit,
          limit: limit,
        )
        .findAll();
    return result;
  }

  Stream<List<T>> oberveQuery<T>(
      {QueryBuilder<T, T, QAfterFilterCondition>? filter,
      String? search}) async* {
    final isar = await db;
    final resol = isar.collection<T>();
    final query = resol.where();
    if (filter != null) {
      query.filter().group((q) => filter).build();
    } else {
      query.build();
    }

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }

  Future<int> delete<T>({required List<int>? ids, List<String>? iddoc}) async {
    final isar = await db;
    final resol = isar.collection<T>();
    final result = await isar
        .writeTxn<int>(() async => await resol.deleteAll(ids!))
        .catchError((onError) {
      print(onError.toString());
      return 1;
    });
    // isar.users.putSync(user);
    return result;
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  FilterCondition _applyFilter(FilterModel elt) {
    return FilterCondition(
      type: elt.filterType == 'equal'
          ? FilterConditionType.equalTo
          : elt.filterType == 'greatThan'
              ? FilterConditionType.greaterThan
              : elt.filterType == 'lessThan'
                  ? FilterConditionType.lessThan
                  : FilterConditionType.contains,
      property: elt.field,
      value1: elt.value,
      caseSensitive: false,
      include1: true,
      include2: true,
    );
  }

  SortProperty _applySort(String field, {Sort value = Sort.desc}) {
    return SortProperty(
      property: field,
      sort: value,
    );
  }
}
