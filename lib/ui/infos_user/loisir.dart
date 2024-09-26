import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/competences.dart';
import 'package:ijshopflutter/ui/infos_user/langue.dart';
import 'package:ijshopflutter/ui/infos_user/resume.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoisirPage(),
    );
  }
}

class LoisirPage extends StatefulWidget {
  @override
  _LoisirPageState createState() => _LoisirPageState();
}

class _LoisirPageState extends State<LoisirPage> {
  TextEditingController _controllerLoisir = TextEditingController();
  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API
  Map<String, String> errors = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerLoisir.dispose();
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
    if (_controllerLoisir.text.isEmpty) {
      errors['nom_loisir'] = 'Ce champ est obligatoire';
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

  void saveuserinfosloisir(String nom_loisir) {
    try {
      final data = {
        'nom_loisir': nom_loisir,
      };
      final response = apiService.saveuserinfosloisir(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LanguePage()));
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
          'LOISIR',
          style: TextStyle(
            color: Colors.white, // Couleur du texte
          ),
        ),
        backgroundColor:
            Colors.blue, // Couleur de l'arrière-plan de la barre d'appBar
        automaticallyImplyLeading:
            false, // Pour ne pas afficher la flèche de retour
        centerTitle: true, // Pour centrer le titre de la page
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
                      'ENTREZ VOS DIFFERENTS LOISIRS  ? ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez vos differents loisirs ',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: _controllerLoisir,
                      keyboardType: TextInputType.text,
                    ),
                    _buildError('nom_loisir'),
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
                          versCompetencesPage(context);

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
                          print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
                          if (_validateFields())
                            saveuserinfosloisir(
                              _controllerLoisir.text,
                            );

                          //versLanguePage(context);
                          // Action à effectuer lors du clic sur le bouton "suivant"
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

void versCompetencesPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CompetencesPage(),
    ),
  );
}

void versLanguePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LanguePage(),
    ),
  );
}
