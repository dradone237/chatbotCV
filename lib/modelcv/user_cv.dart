import 'package:flutter/material.dart';

class CombinedModel {
  // Modèle 1: CertificationModel
  late int id;
  late String intitule;
  late String centreFormation;
  late DateTime date;
  late String description;

  // Modèle 2: CompetenceModel
  late String nomCompetence;
  late String pourcentage;

  // Modèle 3: EducationModel
  late String nomEcole;
  late String diplome;
  late String villeEcole;

  // Modèle 4: ExperienceModel
  late String employeur;
  late String poste;
  late String adresseEntreprise;
  late DateTime dateDebut;
  late DateTime dateFin;

  // Modèle 5: InfoPersoModel
  late String nom;
  late String prenom;
  late String profession;
  late String sexe;
  late String nationalite;
  late DateTime dateNaissance;
  late String email;
  late String image;
  late String adresse;

  // Modèle 6: LangueModel
  late String langue;
  late String pourcentageLangue;

  // Modèle 7: LoisirModel
  late String nomLoisir;

  // Modèle 8: ProjetModel
  late String nomProjet;
  late String entreprise;
  late String anneeRealisation;
  late String urlProjet;

  // Modèle 9: ResumeModel
  late String resume;

  CombinedModel({
    // Modèle 1
    required this.id,
    required this.intitule,
    required this.centreFormation,
    required this.date,
    required this.description,
    // Modèle 2
    required this.nomCompetence,
    required this.pourcentage,
    // Modèle 3
    required this.nomEcole,
    required this.diplome,
    required this.villeEcole,
    // Modèle 4
    required this.employeur,
    required this.poste,
    required this.adresseEntreprise,
    required this.dateDebut,
    required this.dateFin,
    // Modèle 5
    required this.nom,
    required this.prenom,
    required this.profession,
    required this.sexe,
    required this.nationalite,
    required this.dateNaissance,
    required this.email,
    required this.image,
    required this.adresse,
    // Modèle 6
    required this.langue,
    required this.pourcentageLangue,
    // Modèle 7
    required this.nomLoisir,
    // Modèle 8
    required this.nomProjet,
    required this.entreprise,
    required this.anneeRealisation,
    required this.urlProjet,
    // Modèle 9
    required this.resume,
  });

  // Méthode pour initialiser à partir de JSON
  CombinedModel.fromJson(Map<String, dynamic> json) {
    // Modèle 1
    id = json['id'];
    intitule = json['intitule'];
    centreFormation = json['centre_formation'];
    date = DateTime.parse(json['date']);
    description = json['description'];
    // Modèle 2
    nomCompetence = json['nom_competence'];
    pourcentage = json['pourcentage'];
    // Modèle 3
    nomEcole = json['nom_ecole'];
    diplome = json['diplome'];
    villeEcole = json['ville_ecole'];
    // Modèle 4
    employeur = json['employeur'];
    poste = json['poste'];
    adresseEntreprise = json['adresse_entreprise'];
    dateDebut = DateTime.parse(json['date_debut']);
    dateFin = DateTime.parse(json['date_fin']);
    // Modèle 5
    nom = json['nom'];
    prenom = json['prenom'];
    profession = json['profession'];
    sexe = json['sexe'];
    nationalite = json['nationalite'];
    dateNaissance = DateTime.parse(json['date_naissance']);
    email = json['email'];
    image = json['image'];
    adresse = json['adresse'];
    // Modèle 6
    langue = json['langue'];
    pourcentageLangue = json['pourcentage_langue'];
    // Modèle 7
    nomLoisir = json['nom_loisir'];
    // Modèle 8
    nomProjet = json['nom_projet'];
    entreprise = json['entreprise'];
    anneeRealisation = json['annee_realisation'];
    urlProjet = json['url_projet'];
    // Modèle 9
    resume = json['resume'];
  }

  // Méthode pour convertir en JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // Modèle 1
    data['id'] = this.id;
    data['intitule'] = this.intitule;
    data['centre_formation'] = this.centreFormation;
    data['date'] = this.date.toIso8601String();
    data['description'] = this.description;
    // Modèle 2
    data['nom_competence'] = this.nomCompetence;
    data['pourcentage'] = this.pourcentage;
    // Modèle 3
    data['nom_ecole'] = this.nomEcole;
    data['diplome'] = this.diplome;
    // Modèle 3 (suite)
    data['ville_ecole'] = this.villeEcole;
    // Modèle 4
    data['employeur'] = this.employeur;
    data['poste'] = this.poste;
    data['adresse_entreprise'] = this.adresseEntreprise;
    data['date_debut'] = this.dateDebut.toIso8601String();
    data['date_fin'] = this.dateFin.toIso8601String();
    // Modèle 5
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['profession'] = this.profession;
    data['sexe'] = this.sexe;
    data['nationalite'] = this.nationalite;
    data['date_naissance'] = this.dateNaissance.toIso8601String();
    data['email'] = this.email;
    data['image'] = this.image;
    data['adresse'] = this.adresse;
    // Modèle 6
    data['langue'] = this.langue;
    data['pourcentage_langue'] = this.pourcentageLangue;
    // Modèle 7
    data['nom_loisir'] = this.nomLoisir;
    // Modèle 8
    data['nom_projet'] = this.nomProjet;
    data['entreprise'] = this.entreprise;
    data['annee_realisation'] = this.anneeRealisation;
    data['url_projet'] = this.urlProjet;
    // Modèle 9
    data['resume'] = this.resume;
    return data;
  }
}
