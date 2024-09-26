import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/certifications.dart';
import 'package:ijshopflutter/ui/infos_user/loisir.dart';
import 'package:ijshopflutter/ui/infos_user/resume.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompetencesPage(),
    );
  }
}

class CompetencesPage extends StatefulWidget {
  @override
  _CompetencesPageState createState() => _CompetencesPageState();
}

class _CompetencesPageState extends State<CompetencesPage> {
  TextEditingController _controllerNomCompetence = TextEditingController();
  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  Map<String, String> errors = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerNomCompetence.dispose();
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
    if (_controllerNomCompetence.text.isEmpty) {
      errors['nom_competence'] = 'Ce champ est obligatoire';
    }
    // if (_controllerCentreFormation.text.isEmpty) {
    //   errors['centre_formation'] = 'Ce champ est obligatoire';
    // }
    // if (_dateController.text.isEmpty) {
    //   errors['date'] = 'Ce champ est obligatoire';
    // }
    // if (_controllerDescription.text.isEmpty) {
    //   errors['description'] = 'Ce champ est obligatoire';
    // }
    setState(() {});
    return errors.isEmpty;
  }

  void saveuserinfoscompet(String nom_competence) {
    try {
      final data = {
        'nom_competence': nom_competence,
      };
      final response = apiService.saveuserinfoscompet(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoisirPage()));
    } catch (e) {
      print(e);
      print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    }
  }

  DateTime? date;
  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COMPETENCES',
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
          SizedBox(height: 120),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ENTREZ LES COMPETENCES QUE VOUS POSSEDEZ ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez vos differentes competences ',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: _controllerNomCompetence,
                      keyboardType: TextInputType.text,
                    ),
                    _buildError('nom_competence'),
                  ],
                ),
                SizedBox(height: 300),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          versCertificationPage(context);

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
                          print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
                          if (_validateFields())
                            saveuserinfoscompet(
                              _controllerNomCompetence.text,
                            );

                          //versResunePage(context);
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

void versCertificationPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CertificationPage(),
    ),
  );
}

void versLoisirPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoisirPage(),
    ),
  );
}
