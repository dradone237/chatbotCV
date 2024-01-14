import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/services/isar_service.dart';
import 'package:ijshopflutter/services/models/filter_model.dart';
import 'package:ijshopflutter/services/models/user.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final isarService = IsarService();
  late Future<Isar> db;

  final ApiService _httpService = ApiService();
  late Response response;

  // UserRepository() {
  //   db = isarService.openIsar();
  //   isarService.getStatusConnection();
  //   _httpService.init(BaseOptions(baseUrl: SERVER_URL));
  // }

  // Future<User?> save(User item, {dynamic apiToken, dynamic data}) async {
  //   item.isSync = isarService.isServerConnected.value;
  //   if (isarService.isServerConnected.value) {
  //     // appel de l'api
  //     response = await _httpService.dioConnect(USER_PUBLIC_API, apiToken,
  //         data: data, method: Method.POST, contentType: 'multipart/form-data');
  //     final paper = response.data is Map<String, dynamic>
  //         ? User.fromJson(response.data as Map<String, dynamic>)
  //         : item;
  //     await isarService.save<User>(paper);
  //     return paper;
  //   } else {
  //     await isarService.save<User>(item);
  //     return item;
  //   }
  // }

  Stream<List<User>> oberveQuery({String? search}) {
    return isarService.oberveQuery(search: search);
  }

  // Future<List<User>?> query(
  //     {int? skip,
  //     int? limit = 6,
  //     dynamic apiToken,
  //     List<FilterModel>? where,
  //     Map<String, dynamic>? params,
  //     bool sync = false}) async {
  //   try {
  //     final isar = await db;
  //     if (isarService.isServerConnected.value) {
  //       // var postData = {'session_id': sessionId};
  //       response = await _httpService.dioConnect(USER_PUBLIC_API, apiToken,
  //           data: {},
  //           method: Method.GET,
  //           params: {
  //             "orderBy": 'updatedAt',
  //             "orderDirection": "desc",
  //             ...?params,
  //           });

  //       if (response.data != null && response.data?.length > 0) {
  //         if (response.statusCode == STATUS_OK) {
  //           List<dynamic> responseList = ((response.data is List)
  //               ? response.data
  //               : response.data?['data']);
  //           List<User> listData =
  //               responseList.map((f) => User.fromJson(f)).toList();

  //           await isar.writeTxn(() async {
  //             // await isar.infos.clear();
  //             await isar.users.putAll(listData);
  //             // await isar.infos.importJson(responseList);
  //           });
  //           return await getUser(where: where, offset: skip, limit: limit);
  //         } else {
  //           throw Exception(
  //               response.data['msg'] ?? "Une erreur c'est produite");
  //         }
  //       } else {
  //         return await getUser(where: where, offset: skip, limit: limit);
  //       }
  //     } else {
  //       return await getUser(where: where, offset: skip, limit: limit);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<List<User>> getUser({
    List<FilterModel>? where,
    offset = 1,
    limit = 6,
  }) async {
    List list = await isarService.query<User>(
            where: where, offset: offset, limit: limit) ??
        [];
    return list.map((e) => e as User).toList();
  }

  Future<void> delete(User? item, {dynamic data}) async {
    item?.isSync = false;
    item?.isDelete = true;
    if (isarService.isServerConnected.value) {
      await isarService.delete(ids: [item!.isarId]);
      // appel de l'api pour la suppresion
    } else {
      await isarService.save(item);
    }
  }

  Future<dynamic> login(dynamic data, {dynamic apiToken}) async {
    if (isarService.isServerConnected.value) {
      // appel de l'api
      return response = await _httpService.dioConnect(LOGIN_API, apiToken,
          data: data, method: Method.POST, contentType: "application/json");
    } else {
      throw Exception("Verifier votre connection.");
    }
  }

  Future<dynamic> register(dynamic data, {dynamic apiToken}) async {
    if (isarService.isServerConnected.value) {
      // appel de l'api
      response = await _httpService.dioConnect(SIGNUP_API, apiToken,
          content: false,
          data: data,
          method: Method.POST,
          contentType: "application/json");
    } else {
      throw Exception("Verifier votre connection.");
    }
  }

  // Future<dynamic> verify(dynamic data, {dynamic apiToken}) async {
  //   if (isarService.isServerConnected.value) {
  //     // appel de l'api
  //     return response = await _httpService.dioConnect(AUTH_VERIFY_API, apiToken,
  //         data: data, method: Method.POST, contentType: "application/json");
  //   } else {
  //     throw Exception("Verifier votre connection.");
  //   }
  // }

  // Future<dynamic> sendVerificationCode(dynamic data, {dynamic apiToken}) async {
  //   if (isarService.isServerConnected.value) {
  //     // appel de l'api
  //     return response = await _httpService.dioConnect(
  //         AUTH_SEND_PHONE_VERIFY_API, apiToken,
  //         data: data, method: Method.POST, contentType: "application/json");
  //   } else {
  //     throw Exception("Verifier votre connection.");
  //   }
  // }

  // Future<dynamic> sendPasswordVerificationCode(dynamic data,
  //     {dynamic apiToken}) async {
  //   if (isarService.isServerConnected.value) {
  //     // appel de l'api
  //     return response = await _httpService.dioConnect(
  //         AUTH_SEND_PHONE_VERIFY_API, apiToken,
  //         data: data, method: Method.POST, contentType: "application/json");
  //   } else {
  //     throw Exception("Verifier votre connection.");
  //   }
  // }

  // Future<dynamic> resetPassword(dynamic data, {dynamic apiToken}) async {
  //   if (isarService.isServerConnected.value) {
  //     // appel de l'api
  //     return response = await _httpService.dioConnect(
  //         RESET_PASSWORD_API, apiToken,
  //         data: data, method: Method.POST, contentType: "application/json");
  //   } else {
  //     throw Exception("Verifier votre connection.");
  //   }
  // }

  // Future<User?> update(User item, {dynamic apiToken, dynamic data}) async {
  //   item.isSync = isarService.isServerConnected.value;
  //   // if (isarService.isServerConnected.value) {
  //   // appel de l'api
  //   response = await _httpService.dioConnect(
  //       USER_PUBLIC_API + item.id, apiToken,
  //       content: false,
  //       data: data,
  //       method: Method.PATCH,
  //       contentType: 'multipart/form-data');
  //   final usr = response.data is Map<String, dynamic>
  //       ? User.fromJson(response.data as Map<String, dynamic>)
  //       : item;

  //   await isarService.save<User>(usr);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('currentUser', json.encode(usr.toJson()));
  //   return usr;
  //   // } else {
  //   //   await isarService.save<User>(item);
  //   // }
  // }

  // Future<User?> getCurrentUser({dynamic apiToken, dynamic data}) async {
  //   response = await _httpService.dioConnect(
  //     USER_CONNECTED_PUBLIC_API,
  //     apiToken,
  //     method: Method.GET,
  //   );
  //   final datas = (response.data?['data'] is Map<String, dynamic>)
  //       ? (response.data?['data'])
  //       : response.data;

  //   if (datas is Map<String, dynamic>) {
  //     final usr = User.fromJson(datas);
  //     await isarService.save<User>(usr);

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('currentUser', json.encode(usr.toJson()));
  //     return usr;
  //   }
  //   return null;
  //   // } else {
  //   //   await isarService.save<User>(item);
  //   // }
  // }

  // Future<User?> deleteUser(User item, {dynamic apiToken, dynamic data}) async {
  //   item.isSync = isarService.isServerConnected.value;
  //   // if (isarService.isServerConnected.value) {
  //   // appel de l'api
  //   response = await _httpService.dioConnect(
  //       USER_PUBLIC_API + item.id, apiToken,
  //       content: false, data: data, method: Method.DELETE, contentType: '');
  //   final usr = response.data is Map<String, dynamic>
  //       ? User.fromJson(response.data as Map<String, dynamic>)
  //       : item;
  //   await isarService.delete<User>(ids: [usr.isarId]);

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('IsAuth', false);
  //   prefs.setString('UserId', '');
  //   prefs.setString('currentUser', json.encode({}));
  //   prefs.setString('accessToken', '');
  //   prefs.setString('notifications', '[]');
  //   return usr;
  //   // } else {
  //   //   await isarService.save<User>(item);
  //   // }
  // }

  Future<void> cleanUsersDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.users.clear());
  }
}
