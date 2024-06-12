/*
This is api provider
This page is used to get data from API
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/model/activity/activity_model.dart';
import 'package:ijshopflutter/services/models/cvuserModel.dart';
import 'package:ijshopflutter/services/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Method {
  POST,
  GET,
  DELETE,
  PUT,
  DOWNLOAD,
}

class ApiService {
  // cette classe permet de faire les appels D'api
  Dio _dio = Dio();
  late Response response;
  String connErr = 'Please check your internet connection and try again';
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('token');
    return prefs.getString('token');
  }

  Future<String?> gotToken(token) async {
    String tokenWithQuotes = token;
    String tokenWithoutQuotes;

    if (tokenWithQuotes.startsWith('"') && tokenWithQuotes.endsWith('"')) {
      tokenWithoutQuotes =
          tokenWithQuotes.substring(1, tokenWithQuotes.length - 1);
    } else {
      tokenWithoutQuotes = tokenWithQuotes;
    }

    //print(tokenWithoutQuotes);
    return tokenWithoutQuotes;
  }

  Future<String?> getLocale() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? lCode = _pref.getString('lCode');
    return lCode;
  }

  Future<Response> dioConnect(url, apiToken,
      {Method method = Method.POST,
      String downloadPath = "",
      dynamic data,
      Map<String, dynamic>? params,
      bool content = true,
      contentType = 'application/json'}) async {
    try {
      // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (HttpClient client) {
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      //   return client;
      // };

      final String? token = await getToken();
      final String? Token = await gotToken(token);
      print(Token);
      print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
      final String? lang = await getLocale();
      final datetime = DateTime.now();
      if (content) _dio.options.headers['Content-Type'] = contentType;

      _dio.options.connectTimeout = Duration(minutes: 5); //5s
      _dio.options.receiveTimeout = Duration(minutes: 5);
      _dio.options.sendTimeout = Duration(minutes: 5);
      print(url);
      //print('gggggghhhhhhhhhhhhhhhhhhhhyyyyyyyyyyyyyyyyyy');

      _dio.options.headers['time-zone'] = datetime.timeZoneName;
      _dio.options.headers['language'] = lang;
      _dio.options.headers['application'] = "roshub";
      print(token);

      if (token != null) {
        // print(token);
        _dio.options.headers['Authorization'] = 'Bearer $Token';
      }

      if (method == Method.GET) {
        response =
            await _dio.get(url, queryParameters: params, cancelToken: apiToken);
      } else if (method == Method.POST) {
        // _dio!.options.headers['Content-Type'] = 'multipart/form-data';
        response = await _dio.post(url, data: data, cancelToken: apiToken);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url, cancelToken: apiToken);
      } else if (method == Method.PUT) {
        response = await _dio.put(url, data: data, cancelToken: apiToken);
      } else {
        response =
            await _dio.download(url, downloadPath, cancelToken: apiToken);
      }
      return response;
    } on DioError catch (e) {
      print(e.response);
      print(e.response?.data);
      print(e);
      //print(e.toString()+' | '+url.toString());
      // if (e.type == DioErrorType.) {
      //   int? statusCode = e.response!.statusCode;
      //   if (statusCode == STATUS_NOT_FOUND) {
      //     throw "Api not found";
      //   } else if (statusCode == STATUS_INTERNAL_ERROR) {
      //     throw "Internal Server Error";
      //   } else {
      //     throw e;
      //   }
      // } else if (e.type == DioErrorType.connectTimeout) {
      //   throw e.message.toString();
      // } else if (e.type == DioErrorType.cancel) {
      //   throw 'cancel';
      // }

      throw Exception(connErr);
    } finally {
      //dio.close(); que fais cette ligne de code
    }
  }

  Future<dynamic> login(dynamic data, apiToken) async {
    try {
      response = await dioConnect(LOGIN_API, apiToken,
          data:
              data); // cette ligne effectuer un appel d'api en utilisant la bibiotheque Dio, cette ligne apple la fonction dioconnect avec trois parametres qui sont  l'URL de l'API, data (les données de la requête) et apiToken (le jeton d'API) et La fonction dioConnect renvoie une réponse HTTP qui est stockée dans la variable response enfin Le mot-clé await est utilisé pour attendre la fin de l'appel à l'API avant de continuer l'exécution du code, car l'appel à l'API peut prendre du temps pour se terminer.
      // cette condition est utilise pour verifier que reponse.data contient vraiment les information de l'utilisateurs les lignes restantes sont utilisees pour stoker les information de l'utilisateur
      if (response.data['data'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        User user = User.fromJson(response.data[
            'data']); //cette ligne permet de transforme le fichier json retourne pas le serveur (le backend) en um  model user creer
        print('vvvvvvvvvvvvvvvvvvvvv');
        print(response.data);
        print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        print(user);
        print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
        print(json.encode(
            user!)); // cette ligne permet de retournner la liste usermodel enregistre et l'encoder pour l'avoir au serveur en fichier json

        await prefs.setString(
            // cette ligne permet d'enregistre une valeur dans SharedPreferences qui prends deux arguments une cle qui est associe a une valeur dnas notre cas la cle est 'currentUser' et sa valeur est encodee au format json en utilsant la foncton 'json.encode()'
            'currentUser',
            json.encode(user)); // cette ligne est utilise pour encode le user
        await prefs.setString(
            // cette ligne de code est la même chose que la précédente, mais cette fois-ci, elle enregistre une autre valeur dans les préférences partagées sous la clé 'token'. La valeur est également encodée sous forme JSON avec json.encode() en utilisant l'accès à response.data["data"]["accessToken"], puis enregistrée avec setString().
            'token',
            json.encode(response.data["acces_token"]));
        await prefs.setBool("isAuth", true);
        print(response.data["acces_token"]);

        return user;
      } else {
        return response.data;
        //throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> signup(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(SIGNUP_API, apiToken, data: data);
      // cette condition est utilise pour verifier que reponse.data contient vraiment les information de l'utilisateurs les lignes restantes sont utilisees pour stoker les information de l'utilisateur
      if (response.data['user'] != null) {
        SharedPreferences prefs = await SharedPreferences
            .getInstance(); //Cette ligne permet de récupérer une instance de SharedPreferences en appelant la méthode statique getInstance(). La méthode getInstance() renvoie une reponse  Future a une requette , donc en utilisant await, on attend la résolution de cette future et on obtient l'instance de SharedPreferences que l'on stocke dans la variable prefs.
        await prefs.setString(
            //La fonction setString() est asynchrone, donc en utilisant await, on attend que l'opération soit terminée avant de passer à la ligne suivante.
            'currentUser',
            json.encode(response.data["user"]));
        await prefs.setString(
            'token', json.encode(response.data["data"]["acces_token"]));
        await prefs.setBool("hasAccount",
            true); // Cette ligne utilise setBool() pour enregistrer une valeur booléenne dans les préférences partagées. La clé 'isAuth' est associée à la valeur true. Comme précédemment, setBool() est une méthode asynchrone, donc en utilisant await, on attend que l'opération soit terminée avant de passer à la suite du code

        return {};
      } else {
        return response.data;
        //throw Exception(response.data);
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfosperso(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSPERSO_API, apiToken,
          data: data, method: Method.POST);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfoseduc(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSEDUC_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfosexp(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSEXP_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfosproj(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSPROJ_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfoscertif(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSCERTIF_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfoscompet(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSCOMPET_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfosresume(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSRESUME_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfosloisir(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSRELOISIR_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfoslangue(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSRELANGUE_API, apiToken,
          data: data, method: Method.PUT);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<dynamic> saveuserinfostemplate(dynamic data, apiToken) async {
    print(data);
    try {
      response = await dioConnect(INFOSRETEMPLATE_API, apiToken,
          data: data, method: Method.POST);
      print(response);
      print(response.statusMessage);
      if (response.statusMessage == STATUS_OK) {
        List responseList = response.data['data'];
        print(responseList);
        return responseList;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  // Future<dynamic> saveuserinfoschat(dynamic data, apiToken) async {
  //   print(data);
  //   try {
  //     response = await dioConnect(INFOSRECHATBOT_API, apiToken,
  //         data: data, method: Method.POST);
  //     print(response);
  //     print(response.statusMessage);
  //     if (response.statusMessage == STATUS_OK) {
  //       List responseList = response.data['data'];
  //       print(responseList);
  //       return responseList;
  //     } else {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     throw Exception(e.response?.data);
  //   }
  // }

  Future<List<CvuserModel>> getCvHistory(CancelToken apiToken) async {
    try {
      // Utilisez la méthode dioConnect pour effectuer la requête
      final response = await dioConnect(
        INFOSCVHISTORY_API,
        apiToken,
        method: Method.GET,
      );

      // Vérifiez si la réponse est réussie
      if (response.statusCode == 200) {
        // print('Response data: ${response.data}');
        List<dynamic> data = response
            .data['data']; // Assurez-vous que 'data' est la clé correcte
        return data.map((cv) {
          // print('CV JSON: $cv');
          return CvuserModel.fromJson(cv);
        }).toList();
      } else {
        throw Exception('Failed to load CV history: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      print('General error: $e');
      throw Exception('General error: $e');
    }
  }

  Future<dynamic> downloadcv(CancelToken apiToken, String id) async {
    try {
      // Utilisez la méthode dioConnect pour effectuer la requête
      final response = await dioConnect(
        DOWNLOADCV_API + id,
        apiToken,
        method: Method.GET,
      );
      return response.data;
      // Vérifiez si la réponse est réussie
      // ignore: dead_code
      if (response.statusCode == 200) {
        // print('Response data: ${response.data}');
        List<dynamic> data = response
            .data['data']; // Assurez-vous que 'data' est la clé correcte
        return data.map((cv) {
          // print('CV JSON: $cv');
          return CvuserModel.fromJson(cv);
        }).toList();
      } else {
        throw Exception('Failed to load CV history: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      print('General error: $e');
      throw Exception('General error: $e');
    }
  }

  // Future<dynamic> uploadImage(dynamic data, apiToken) async {
  //   print(data);
  //   try {
  //     response = await dioConnect(UPLOADIMAGE_API, apiToken,
  //         data: data, method: Method.POST);
  //     print(response);
  //     print(response.statusMessage);
  //     if (response.statusMessage == STATUS_OK) {
  //       List responseList = response.data['data'];
  //       print(responseList);
  //       return responseList;
  //     } else {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     throw Exception(e.response?.data);
  //   }
  // }
}




  // Future<dynamic> getCvHistory(apiToken) async {
  //   try {
  //     // Définir l'URL de l'API pour récupérer l'historique des CV
  //     final String url = '$INFOSCVHISTORY_API';

  //     // Appeler la méthode dioConnect avec la méthode GET
  //     response = await dioConnect(url, apiToken, method: Method.GET);

  //     // Vérifier si la réponse contient les données de l'historique des CV
  //     if (response.data['data'] != null) {
  //       // Retourner les données de l'historique des CV
  //       List cvHistory = response.data['data'];
  //       return cvHistory;
  //     } else {
  //       // Retourner la réponse entière si les données ne sont pas trouvées
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     // Gérer les erreurs et renvoyer une exception
  //     throw Exception(e.response?.data);
  //   }
  // }

  // Future<dynamic> signup(dynamic data, apiToken) async {
  //   print(data);
  //   try {
  //     response = await dioConnect(SIGNUP_API, apiToken, data: data);
  //     // cette condition est utilise pour verifier que reponse.data contient vraiment les information de l'utilisateurs les lignes restantes sont utilisees pour stoker les information de l'utilisateur
  //     if (response.data['user'] != null) {
  //       SharedPreferences prefs = await SharedPreferences
  //           .getInstance(); //Cette ligne permet de récupérer une instance de SharedPreferences en appelant la méthode statique getInstance(). La méthode getInstance() renvoie une reponse  Future a une requette , donc en utilisant await, on attend la résolution de cette future et on obtient l'instance de SharedPreferences que l'on stocke dans la variable prefs.
  //       await prefs.setString(
  //           //La fonction setString() est asynchrone, donc en utilisant await, on attend que l'opération soit terminée avant de passer à la ligne suivante.
  //           'currentUser',
  //           json.encode(response.data["user"]));
  //       await prefs.setString(
  //           'token', json.encode(response.data["data"]["accessToken"]));
  //       await prefs.setBool("hasAccount",
  //           true); // Cette ligne utilise setBool() pour enregistrer une valeur booléenne dans les préférences partagées. La clé 'isAuth' est associée à la valeur true. Comme précédemment, setBool() est une méthode asynchrone, donc en utilisant await, on attend que l'opération soit terminée avant de passer à la suite du code

  //       return {};
  //     } else {
  //       return response.data;
  //       //throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     throw Exception(e.response?.data);
  //   }
  // }

  //signup(Map<String, String> data, CancelToken apiToken) {}

  // Future<dynamic> login(dynamic data, apiToken) async {
  //   try {
  //     response = await dioConnect(LOGIN_API, apiToken,
  //         data:
  //             data); // cette ligne effectuer un appel d'api en utilisant la bibiotheque Dio, cette ligne apple la fonction dioconnect avec trois parametres qui sont  l'URL de l'API, data (les données de la requête) et apiToken (le jeton d'API) et La fonction dioConnect renvoie une réponse HTTP qui est stockée dans la variable response enfin Le mot-clé await est utilisé pour attendre la fin de l'appel à l'API avant de continuer l'exécution du code, car l'appel à l'API peut prendre du temps pour se terminer.
  //     // cette condition est utilise pour verifier que reponse.data contient vraiment les information de l'utilisateurs les lignes restantes sont utilisees pour stoker les information de l'utilisateur
  //     if (response.data['user'] != null) {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       User user = User.fromJson(response.data[
  //           'user']); //cette ligne permet de transforme le fichier json retourne pas le serveur (le backend) en um  model user creer
  //       print(json.encode(
  //           user!)); // cette ligne permet de retournner la liste usermodel enregistre et l'encoder pour l'avoir au serveur en fichier json

  //       await prefs.setString(
  //           // cette ligne permet d'enregistre une valeur dans SharedPreferences qui prends deux arguments une cle qui est associe a une valeur dnas notre cas la cle est 'currentUser' et sa valeur est encodee au format json en utilsant la foncton 'json.encode()'
  //           'currentUser',
  //           json.encode(user)); // cette ligne est utilise pour encode le user
  //       await prefs.setString(
  //           // cette ligne de code est la même chose que la précédente, mais cette fois-ci, elle enregistre une autre valeur dans les préférences partagées sous la clé 'token'. La valeur est également encodée sous forme JSON avec json.encode() en utilisant l'accès à response.data["data"]["accessToken"], puis enregistrée avec setString().
  //           'token',
  //           json.encode(response.data["data"]["accessToken"]));
  //       await prefs.setBool("isAuth", true);

  //       return user;
  //     } else {
  //       return response.data;
  //       //throw Exception(response.data);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<dynamic> signup(dynamic data, apiToken) async {
  //   print(data);
  //   try {
  //     response = await dioConnect(SIGNUP_API, apiToken, data: data);
  //     // cette condition est utilise pour verifier que reponse.data contient vraiment les information de l'utilisateurs les lignes restantes sont utilisees pour stoker les information de l'utilisateur
  //     if (response.data['user'] != null) {
  //       SharedPreferences prefs = await SharedPreferences
  //           .getInstance(); //Cette ligne permet de récupérer une instance de SharedPreferences en appelant la méthode statique getInstance(). La méthode getInstance() renvoie une reponse  Future a une requette , donc en utilisant await, on attend la résolution de cette future et on obtient l'instance de SharedPreferences que l'on stocke dans la variable prefs.
  //       await prefs.setString(
  //           //La fonction setString() est asynchrone, donc en utilisant await, on attend que l'opération soit terminée avant de passer à la ligne suivante.
  //           'currentUser',
  //           json.encode(response.data["user"]));
  //       await prefs.setString(
  //           'token', json.encode(response.data["data"]["accessToken"]));
  //       await prefs.setBool("hasAccount",
  //           true); // Cette ligne utilise setBool() pour enregistrer une valeur booléenne dans les préférences partagées. La clé 'isAuth' est associée à la valeur true. Comme précédemment, setBool() est une méthode asynchrone, donc en utilisant await, on attend que l'opération soit terminée avant de passer à la suite du code

  //       return {};
  //     } else {
  //       return response.data;
  //       //throw Exception(response.data);
  //     }
  //   } on DioError catch (e) {
  //     throw Exception(e.response?.data);
  //   }
  // }

  // Future<void> createActivity(ActivityModel activity, apiToken) async {
  //   try {
  //     response =
  //         await dioConnect(ACTIVITY_API, apiToken, data: activity.toJson());
  //     print(response.data);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  //dioConnect(String signup_api, data, apiToken) {

