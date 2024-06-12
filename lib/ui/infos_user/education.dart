import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/experience.dart';
import 'package:ijshopflutter/ui/infos_user/preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EducationPage(),
    );
  }
}

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  TextEditingController _controllerNomEcole = TextEditingController();
  TextEditingController _controllerDiplome = TextEditingController();
  TextEditingController _controllerVilleEcole = TextEditingController();
  TextEditingController _controllerdate = TextEditingController();

  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  // Ajout des variables pour gérer les erreurs
  Map<String, String> errors = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerNomEcole.dispose();
    _controllerDiplome.dispose();
    _controllerVilleEcole.dispose();
    _controllerdate.dispose();

    super.dispose();
  }

  // Méthode pour afficher les messages d'erreur
  Widget _buildError(String field) {
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
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
        : Container();
  }

  // Méthode pour vérifier les champs
  bool _validateFields() {
    errors.clear();
    if (_controllerNomEcole.text.isEmpty) {
      errors['nom_ecole'] = 'Ce champ est obligatoire';
    }
    if (_controllerDiplome.text.isEmpty) {
      errors['diplome'] = 'Ce champ est obligatoire';
    }
    if (_controllerVilleEcole.text.isEmpty) {
      errors['ville_ecole'] = 'Ce champ est obligatoire';
    }
    if (_dateController.text.isEmpty) {
      errors['date'] = 'Ce champ est obligatoire';
    }
    setState(() {});
    return errors.isEmpty;
  }

  void saveuserinfoseduc(
      String nomEcole, String diplome, String villeEcole, String date) {
    try {
      final data = {
        'nom_ecole': nomEcole,
        'diplome': diplome,
        'ville_ecole': villeEcole,
        'date': selectedDate.toIso8601String(),
      };
      final response = apiService.saveuserinfoseduc(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ExperiencePage()));
    } catch (e) {
      print(e);
      print('Erreur lors de l\'enregistrement des informations éducatives');
    }
  }

  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }

  // DateTime? date;
  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDUCATION',
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
                      'QUEL EST VOTRE DIPLOME ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez votre diplôme',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerDiplome,
                    ),
                    _buildError('diplome'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'OU AVEZ-VOUS OBTENU VOTRE DIPLOME?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez le nom de votre ecole ',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerNomEcole,
                    ),
                    _buildError('nom_ecole'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ou SE SITUE L\'\ ETABLISSEMENT ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez la ville de Etablissement  ',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerVilleEcole,
                    ),
                    _buildError('ville_ecole'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'QUAND AVEZ-VOUS OBTENU VOTRE DIPLOME ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Entrez la date ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    _buildError('date'),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          versPreferencesPage(context);

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
                          if (_validateFields()) {
                            saveuserinfoseduc(
                              _controllerNomEcole.text,
                              _controllerDiplome.text,
                              _controllerVilleEcole.text,
                              _dateController.text,
                            );

                            versExperiencePage(context);
                          }
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

void versExperiencePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ExperiencePage(),
    ),
  );
}

void versPreferencesPage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => PreferencesPage(),
    ),
  );
}
