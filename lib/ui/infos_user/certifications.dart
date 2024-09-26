import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/competences.dart';
import 'package:ijshopflutter/ui/infos_user/experience.dart';
import 'package:ijshopflutter/ui/infos_user/projet.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CertificationPage(),
    );
  }
}

class CertificationPage extends StatefulWidget {
  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  TextEditingController _controllerIntitule = TextEditingController();
  TextEditingController _controllerCentreFormation = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API
  Map<String, String> errors = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerIntitule.dispose();
    _controllerCentreFormation.dispose();
    _controllerDescription.dispose();
    _dateController.dispose();
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
    if (_controllerIntitule.text.isEmpty) {
      errors['intitule'] = 'Ce champ est obligatoire';
    }
    if (_controllerCentreFormation.text.isEmpty) {
      errors['centre_formation'] = 'Ce champ est obligatoire';
    }
    if (_dateController.text.isEmpty) {
      errors['date'] = 'Ce champ est obligatoire';
    }
    if (_controllerDescription.text.isEmpty) {
      errors['description'] = 'Ce champ est obligatoire';
    }
    setState(() {});
    return errors.isEmpty;
  }

  void saveuserinfoscertif(String intitule, String centre_formation,
      String description, String date) {
    try {
      final data = {
        'intitule': intitule,
        'centre_formation': centre_formation,
        'date': date,
        'description': description,
      };
      final response = apiService.saveuserinfoscertif(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CompetencesPage()));
    } catch (e) {
      print(e);
      print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
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
          'CERTIFICATIONS',
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
                      'QUEL ETAIT LE NOM DU CERTIFICAT ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez le nom du certificat',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerIntitule,
                    ),
                    _buildError('intitule'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'OU AS-TU OBTENU LE CERTIFICAT?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez le nom de la plateforme',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerCentreFormation,
                    ),
                    _buildError('centre_formation'),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'QUAND AS-TU OBTENU LE CERTIFICAT ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Entrez la date',
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
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Text(
                //       'QUAND AS-TU OBTENU LE CERTIFICAT ?',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     TextFormField(
                //       decoration: InputDecoration(
                //         labelText: 'Ddate 2024  ',
                //         labelStyle: TextStyle(fontSize: 12),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'EN QUOI LE CERTIFICAT EST-IL PERTIMENT ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Defini la competence du certificat  ',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controllerDescription,
                    ),
                    _buildError('description'),
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
                          versExperiencePage(context);

                          // Action à effectuer lors du clic sur le bouton "Suivant"
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
                          if (_validateFields())
                            saveuserinfoscertif(
                              _controllerIntitule.text,
                              _controllerCentreFormation.text,
                              _controllerDescription.text,
                              _dateController.text,
                            );

                          //versCompetencesPage(context);
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

void versExperiencePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ExperiencePage(),
    ),
  );
}

void versCompetencesPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CompetencesPage(),
    ),
  );
}
