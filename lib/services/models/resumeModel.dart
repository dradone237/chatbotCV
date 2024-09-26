import 'package:ijshopflutter/services/common/helper.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'resumeModel.g.dart';

@Collection()
class ResumeModel {
  late String id = Uuid().v4();
  Id get isarId => fastHash(id);
  List<Resume>? resumes;

  ResumeModel({
    this.resumes,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      resumes: json['resumes'] != null
          ? (json['resumes'] as List<dynamic>)
              .map((r) => Resume.fromJson(r))
              .toList()
          : [],
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        'resumes': resumes?.map((r) => r.toJson()).toList() ?? [],
      };
}

@embedded
class Resume {
  String? titre;
  String? description;
  String? periode;

  Resume({
    this.titre,
    this.description,
    this.periode,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      titre: json['titre'],
      description: json['description'],
      periode: json['periode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'description': description,
      'periode': periode,
    };
  }
}
