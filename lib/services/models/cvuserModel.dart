import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/common/helper.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'cvuserModel.g.dart';

@Collection()
class CvuserModel {
  late String id = Uuid().v4();
  Id get isarId => fastHash(id);
  late String userId;
  late String path;
  late String dateCreation;

  CvuserModel({
    required this.userId,
    required this.path,
    required this.dateCreation,
  });

  // Convertit un JSON en instance de CvuserModel

  factory CvuserModel.fromJson(Map<String, dynamic> json) {
    //print(json["data"]["data"]);
    return CvuserModel(
      userId: json['userId'].toString(),
      dateCreation: json['date_creation'],
      path: json["path"],
    )..id = json['id'].toString() ?? Uuid().v4();
  }

  // Convertit une instance de CvuserModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'path': path,
      'date_creation': dateCreation,
    };
  }
}
