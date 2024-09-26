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
  late String docpath;
  late DateTime dateCreation;

  CvuserModel({
    required this.userId,
    required this.path,
    required this.dateCreation,
    required this.docpath,
  });

  // Convertit un JSON en instance de CvuserModel

  factory CvuserModel.fromJson(Map<String, dynamic> json) {
    //print(json["data"]["data"]);
    return CvuserModel(
      userId: json['userId'].toString(),
      dateCreation: DateTime.parse(json['date_creation']),
      path: json["path"],
      docpath: json["docxPath"],
    )..id = json['id'].toString() ?? Uuid().v4();
  }

  // Convertit une instance de CvuserModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'path': path,
      'docpath': docpath,
      'date_creation': dateCreation.toIso8601String(),
    };
  }
}
