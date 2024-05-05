import 'package:ijshopflutter/services/common/helper.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@Collection()
class User {
  late String id = Uuid().v4();
  Id get isarId => fastHash(id);

  String? nom;
  String? prenom;

  String? email;
  String? profession;
  String? adresse;
  String? nationalite;
  String? telephone;
  DateTime? date_naissance;

  String? sexe;
  User({
    this.nom,
    this.prenom,
    this.email,
    this.date_naissance,
    this.nationalite,
    this.adresse,
    this.profession,
    this.telephone,
    this.sexe,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      //ode: json['code'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      email: json['email'],
      sexe: json['sexe'],
      adresse: json['adresse'],
      nationalite: json['nationalite'],
      profession: json['profession'],
      date_naissance: json['date_naissance'] != null
          ? DateTime.parse(json['date_naissance'])
          : null,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        // 'isarId': isarId,
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'email': email,
        'nationalite': nationalite,
        'adresse': adresse,
        'sexe': (sexe),
        'profession': profession,
        'date_naissance': date_naissance?.toIso8601String(),
      };
}

@embedded
class Comment {
  String? id = Uuid().v4();
  String? picture;
  String? comment;
  int? rate;
  String? name;
  List<String>? likes;
  String? parentId;
  String? user;
  DateTime? createAt;
  DateTime? updateAt;

  Comment({
    // this.id,
    this.picture,
    this.comment,
    this.rate,
    this.name,
    this.likes,
    this.parentId,
    this.user,
    this.createAt,
    this.updateAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      // id: json['_id'],
      picture: json['picture'],
      comment: json['comment'],
      rate: json['rate'] != null ? (json['rate'] as num?)?.toInt() : 0,
      name: json['name'],
      likes: (json['likes'] as List<dynamic>?)?.cast<String>() ?? [],
      parentId: json['parentId'],
      user: json['user'] is String ? json['user'] : "",
      createAt:
          json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id ?? Uuid().v4(),
      'picture': picture,
      'comment': comment,
      'rate': rate,
      'name': name,
      'likes': likes,
      'parentId': parentId,
      'user': user,
      'createAt': createAt?.toUtc().toIso8601String(),
      'updateAt': updateAt?.toUtc().toIso8601String(),
    };
  }
}

enum Sexe {
  HOMME,
  FEMME,
}
