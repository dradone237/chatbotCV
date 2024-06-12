import 'package:ijshopflutter/services/common/helper.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'competenceModel.g.dart';

@Collection()
class CompetenceModel {
  late String id = Uuid().v4();
  Id get isarId => fastHash(id);
  List<Competence>? competences;

  CompetenceModel({
    this.competences,
  });

  factory CompetenceModel.fromJson(Map<String, dynamic> json) {
    return CompetenceModel(
      competences: json['competences'] != null
          ? (json['competences'] as List<dynamic>)
              .map((c) => Competence.fromJson(c))
              .toList()
          : [],
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        'competences': competences?.map((c) => c.toJson()).toList() ?? [],
      };
}

@embedded
class Competence {
  String? nomCompetence;
  String? justification;
  List<String>? lieuFormation;

  Competence({
    this.nomCompetence,
    this.justification,
    this.lieuFormation,
  });

  factory Competence.fromJson(Map<String, dynamic> json) {
    return Competence(
      nomCompetence: json['nom_competence'],
      justification: json['justification'],
      lieuFormation:
          (json['lieu_formation'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom_competence': nomCompetence,
      'justification': justification,
      'lieu_formation': lieuFormation,
    };
  }
}
