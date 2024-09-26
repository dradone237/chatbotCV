import 'package:ijshopflutter/services/common/helper.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'cvModel.g.dart';

@Collection()
class CvModel {
  late String id = Uuid().v4();
  Id get isarId => fastHash(id);
  List<PlanCarrier>? planCarriers;

  CvModel({
    this.planCarriers,
  });

  factory CvModel.fromJson(Map<String, dynamic> json) {
    return CvModel(
      planCarriers: json['plan_carrier'] != null
          ? (json['plan_carrier'] as List<dynamic>)
              .map((c) => PlanCarrier.fromJson(c))
              .toList()
          : [],
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        'plan_carrier': planCarriers?.map((c) => c.toJson()).toList() ?? [],
      };
}

@embedded
class PlanCarrier {
  String? poste;
  String? description;
  List<String>? competenceRequises;
  List<String>? centreFormation;
  List<String>? certification;

  PlanCarrier({
    // this.id,
    this.description,
    this.poste,
    this.competenceRequises,
    this.centreFormation,
    this.certification,
  });

  factory PlanCarrier.fromJson(Map<String, dynamic> json) {
    return PlanCarrier(
      // id: json['_id'],

      poste: json['poste'],
      description: json['description'],
      competenceRequises:
          (json['competence_requises'] as List<dynamic>?)?.cast<String>() ?? [],
      centreFormation:
          (json['centre_formation'] as List<dynamic>?)?.cast<String>() ?? [],
      certification:
          (json['certification'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poste': poste,
      'description': description,
      'competence_requises': competenceRequises,
      'centre_formation': centreFormation,
      'certification': certification,
    };
  }
}
