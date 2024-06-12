import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/certifications.dart';
import 'package:ijshopflutter/ui/infos_user/loisir.dart';
import 'package:ijshopflutter/ui/infos_user/resume.dart';
import 'package:ijshopflutter/ui/infos_user/templates_cv.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LanguePage(),
    );
  }
}

class LanguePage extends StatefulWidget {
  @override
  _CompetencesPageState createState() => _CompetencesPageState();
}

class _CompetencesPageState extends State<LanguePage> {
  TextEditingController _controllerLangue = TextEditingController();
  TextEditingController _controllerpourcentage = TextEditingController();
  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API
  Map<String, String> errors = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerLangue.dispose();
    _controllerpourcentage.dispose();
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
    if (_controllerLangue.text.isEmpty) {
      errors['langue'] = 'Ce champ est obligatoire';
    }
    if (_controllerpourcentage.text.isEmpty) {
      errors['pourcentage'] = 'Ce champ est obligatoire';
    }
    // if (_dateController.text.isEmpty) {
    //   errors['date'] = 'Ce champ est obligatoire';
    // }
    // if (_controllerDescription.text.isEmpty) {
    //   errors['description'] = 'Ce champ est obligatoire';
    // }
    setState(() {});
    return errors.isEmpty;
  }

  void saveuserinfoslangue(String langue, String pourcentage) {
    try {
      final data = {
        'langue': langue,
        'pourcentage': pourcentage,
      };
      final response = apiService.saveuserinfoslangue(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CVTemplatesScreen()));
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
          'LANGUES',
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
                      'ENTREZ LES LANGUES QUE VOUS POSSEDEZ ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez vos differentes langues',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: _controllerLangue,
                      keyboardType: TextInputType.text,
                    ),
                    _buildError('langue'),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Entrez le pourcentage de la langue ',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: _controllerpourcentage,
                      keyboardType: TextInputType.text,
                    ),
                    _buildError('pourcentage'),
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
                          versLoisirPage(context);

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
                            saveuserinfoslangue(
                              _controllerLangue.text,
                              _controllerpourcentage.text,
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

void versLoisirPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoisirPage(),
    ),
  );
}

void versCVTemplatesScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CVTemplatesScreen(),
    ),
  );
}
