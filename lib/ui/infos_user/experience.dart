import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/certifications.dart';
import 'package:ijshopflutter/ui/infos_user/education.dart';
import 'package:ijshopflutter/ui/infos_user/preferences.dart';
import 'package:ijshopflutter/ui/infos_user/projet.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExperiencePage(),
    );
  }
}

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  TextEditingController _controllerPoste = TextEditingController();
  TextEditingController _controllerNomEntreprise = TextEditingController();
  TextEditingController _controllerVilleEntreprise = TextEditingController();
  TextEditingController _controllerResumeEntreprise = TextEditingController();

  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  Map<String, String> errors = {}; // Déclaration des erreurs

  @override
  void initState() {
    super.initState();
    _firstDateController =
        TextEditingController(); // Initialisation de _firstDateController
    _secondDateController =
        TextEditingController(); // Initialisation de _secondDateController
  }

  @override
  void dispose() {
    _controllerPoste.dispose();
    _controllerNomEntreprise.dispose();
    _controllerVilleEntreprise.dispose();
    _controllerResumeEntreprise.dispose();
    _firstDateController.dispose(); // Disposition de _firstDateController
    _secondDateController.dispose(); // Disposition de _secondDateController
    super.dispose();
  }

  // Méthode pour afficher les messages d'erreur
  Widget _buildError(String field, {double fontSize = 10.0}) {
    return errors.containsKey(field)
        ? Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.yellow,
              ),
              SizedBox(width: 5),
              Text(
                errors[field]!,
                style: TextStyle(color: Colors.red, fontSize: fontSize),
              ),
            ],
          )
        : Container();
  }

  // Méthode pour vérifier les champs
  bool _validateFields() {
    errors.clear();
    if (_controllerPoste.text.isEmpty) {
      errors['poste'] = 'Ce champ est obligatoire';
    }
    if (_controllerNomEntreprise.text.isEmpty) {
      errors['employeur'] = 'Ce champ est obligatoire';
    }
    if (_firstDateController.text.isEmpty) {
      errors['date_debut'] = 'Ce champ est obligatoire';
    }
    if (_secondDateController.text.isEmpty) {
      errors['date_fin'] = 'Ce champ est obligatoire';
    }
    if (_controllerVilleEntreprise.text.isEmpty) {
      errors['adresse_entreprise'] = 'Ce champ est obligatoire';
    }
    if (_controllerResumeEntreprise.text.isEmpty) {
      errors['description'] = 'Ce champ est obligatoire';
    }
    setState(() {});
    return errors.isEmpty;
  }

  void saveuserinfosexp(String poste, String employeur, String date_debut,
      String date_fin, String adresse_entreprise, String description) {
    try {
      final data = {
        'poste': poste,
        'employeur': employeur,
        'date_debut': date_debut,
        'date_fin': date_fin,
        'adresse_entreprise': adresse_entreprise,
        'description': description,
      };
      final response = apiService.saveuserinfosexp(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CertificationPage()));
    } catch (e) {
      print(e);
      print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    }
  }

  TextEditingController _dateController = TextEditingController();
  TextEditingController _firstDateController =
      TextEditingController(); // Initialisation de _firstDateController
  TextEditingController _secondDateController =
      TextEditingController(); // Initialisation de _secondDateController

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // DateTime? date;
  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EXPERIENCE',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'QUEL ETAIT VOTRE ROLE DANS L\'\ ENTREPRISE ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez votre poste',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerPoste,
                    ),
                    _buildError('poste'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'POUR QUEL ENTREPRISE AVEZ-VOUS TRAVAILLE ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez le nom de l\'entreprise',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerNomEntreprise,
                    ),
                    _buildError('employeur'),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'COMBIEN DE TEMPS ETES-VOUS RESTE DANS L\'ENTREPRISE ?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Date de début',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                readOnly: true,
                                controller: _firstDateController,
                                onTap: () {
                                  _selectDate(context, _firstDateController);
                                },
                              ),
                              SizedBox(
                                  height: 5), // Ajout d'un espacement vertical
                              _buildError('date_debut',
                                  fontSize:
                                      8), // Affichage de l'erreur avec taille réduite
                            ],
                          ),
                        ),
                        SizedBox(width: 10), // Espace entre les champs
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Date de fin',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                readOnly: true,
                                controller: _secondDateController,
                                onTap: () {
                                  _selectDate(context, _secondDateController);
                                },
                              ),
                              SizedBox(
                                  height: 5), // Ajout d'un espacement vertical
                              _buildError('date_fin',
                                  fontSize:
                                      8), // Affichage de l'erreur avec taille réduite
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'OU ETAIT SITUEE L\'\ ENTREPRISE ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Ville de l\'\entreprise',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerVilleEntreprise,
                    ),
                    _buildError('adresse_entreprise'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'QU AVEZ-VOUS FAIT DANS L\'\ENTREPRISE ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Une Bref description de vos realisation',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerResumeEntreprise,
                    ),
                    _buildError('description'),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          versEducationPage(context);
                          // Action à effectuer lors du clic sur le bouton "retour"
                        },
                        child: Text('Retour',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
                          if (_validateFields()) {
                            saveuserinfosexp(
                              _controllerPoste.text,
                              _controllerNomEntreprise.text,
                              _firstDateController.text,
                              _secondDateController.text,
                              _controllerVilleEntreprise.text,
                              _controllerResumeEntreprise.text,
                            );

                            versCertificationPage(context);
                          }
                          // Action à effectuer lors du clic sur le bouton "Retour"
                        },
                        child: Text('Suivant',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void versEducationPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EducationPage(),
    ),
  );
}

void versCertificationPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CertificationPage(),
    ),
  );
}
