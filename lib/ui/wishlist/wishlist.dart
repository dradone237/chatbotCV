import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_profile_picture.dart';
import 'package:ijshopflutter/ui/home/home1.dart';
import 'package:ijshopflutter/ui/infos_user/education.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
//import 'education.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  // initialisation de la fonction globale
  bool _buttonDisabled = true;
  String _validate = '';

  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerProfession = TextEditingController();
  TextEditingController _controllerNationalite = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _sexeController = TextEditingController();
  TextEditingController _controllerAdresse = TextEditingController();
  TextEditingController _controllerdateNaissance = TextEditingController();

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
    _controllerNom.dispose();
    _controllerPrenom.dispose();
    _controllerProfession.dispose();
    _controllerNationalite.dispose();
    _controllerEmail.dispose();
    _sexeController.dispose();
    _controllerAdresse.dispose();
    _controllerdateNaissance.dispose();

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
    if (_controllerNom.text.isEmpty) {
      errors['nom'] = 'Ce champ est obligatoire';
    }
    if (_controllerPrenom.text.isEmpty) {
      errors['prenom'] = 'Ce champ est obligatoire';
    }
    if (_controllerEmail.text.isEmpty) {
      errors['email'] = 'Ce champ est obligatoire';
    }
    if (_controllerProfession.text.isEmpty) {
      errors['profession'] = 'Ce champ est obligatoire';
    }
    if (_controllerAdresse.text.isEmpty) {
      errors['adresse'] = 'Ce champ est obligatoire';
    }
    if (_sexeController.text.isEmpty) {
      errors['sexe'] = 'Ce champ est obligatoire';
    }
    if (_dateController.text.isEmpty) {
      errors['date_naissance'] = 'Ce champ est obligatoire';
    }
    setState(() {});
    return errors.isEmpty;
  }

  void saveuserinfosperso(
    String nom,
    String prenom,
    String profession,
    String sexe,
    String nationalite,
    String email,
    String adresse,
    String dateNaissance,
    //File image,
  ) {
    try {
      final data = {
        'nom': nom,
        'prenom': prenom,
        'profession': profession,
        'adresse': adresse,
        'email': email,
        'nationalite': nationalite,
        'sexe': sexe,
        'date_naissance': dateNaissance,
      };
      final response = apiService.saveuserinfosperso(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EducationPage()));
    } catch (e) {
      print(e);
      print('Erreur lors de l\'enregistrement des informations personnelles');
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

  // liste des pays
  String selectedCountry = 'Cameroun'; // Pays sélectionné par défaut
  List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Cameroun'
    // ... Ajoutez d'autres pays ici
  ];

  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information Personnel',
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
          SizedBox(height: 20),
          _createProfilePicture(context),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nom'),
                  keyboardType: TextInputType.text,
                  controller: _controllerNom,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (textValue) {},
                ),
                _buildError('nom'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Prenom'),
                  keyboardType: TextInputType.text,
                  controller: _controllerPrenom,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (textValue) {
                    setState(() {});
                  },
                ),
                _buildError('prenom'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.text,
                  controller: _controllerEmail,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (textValue) {
                    setState(() {});
                  },
                ),
                _buildError('email'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Profession'),
                  keyboardType: TextInputType.text,
                  controller: _controllerProfession,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (textValue) {
                    setState(() {});
                  },
                ),
                _buildError('profession'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Adresse'),
                  keyboardType: TextInputType.text,
                  controller: _controllerAdresse,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (textValue) {
                    setState(() {});
                  },
                ),
                _buildError('adresse'),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: selectedCountry),
                  decoration: InputDecoration(
                    labelText: 'nationalite',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onTap: () {
                    _showCountryPicker(context);
                  },
                  onChanged: (textValue) {},
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Date de naissance: 30/03/1990',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: '',
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                      onChanged: (textValue) {},
                    ),
                    _buildError('date_naissance'),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Radio(
                      value: 'Homme',
                      groupValue: _sexeController.text,
                      onChanged: (value) {
                        setState(() {
                          _sexeController.text = value as String;
                        });
                      },
                    ),
                    Text(
                      'Homme',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Radio(
                      value: 'Femme',
                      groupValue: _sexeController.text,
                      onChanged: (value) {
                        setState(() {
                          _sexeController.text = value as String;
                        });
                      },
                    ),
                    Text(
                      'Femme',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                _buildError('sexe'),
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
                          versHomePage(context);
                          // Action à effectuer lors du clic sur le bouton "Retour"
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
                            saveuserinfosperso(
                              _controllerNom.text,
                              _controllerPrenom.text,
                              _controllerProfession.text,
                              _sexeController.text,
                              selectedCountry,
                              _controllerEmail.text,
                              _controllerAdresse.text,
                              _dateController.text,
                            );

                            versEducationPage(context);
                          }
                        },
                        // Action à effectuer lors du clic sur le bouton "Suivant"
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

  void _showCountryPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionnez un pays ?'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(countries[index]),
                  onTap: () {
                    setState(() {
                      selectedCountry = countries[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
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

Widget _createProfilePicture(BuildContext context) {
  final double profilePictureSize = MediaQuery.of(context).size.width / 3;
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: EdgeInsets.only(top: 40),
      width: profilePictureSize,
      height: profilePictureSize,
      child: GestureDetector(
        onTap: () {
          _showPopupUpdatePicture(context);
        },
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: (profilePictureSize),
              child: Hero(
                tag: 'profilePicture',
                child: ClipOval(
                    child: buildCacheNetworkImage(
                        width: profilePictureSize,
                        height: profilePictureSize,
                        url: GLOBAL_URL + 'assets/images/placeholder.jpg')),
              ),
            ),
            // create edit icon in the picture
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(
                  top: 0, left: MediaQuery.of(context).size.width / 4),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 1,
                child: Icon(Icons.edit, size: 12, color: CHARCOAL),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _verifiedLabel(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
    decoration:
        BoxDecoration(color: SOFT_BLUE, borderRadius: BorderRadius.circular(2)),
    child: Row(
      children: [
        Text(AppLocalizations.of(context)!.translate('verified')!,
            style: TextStyle(color: Colors.white, fontSize: 11)),
        SizedBox(
          width: 4,
        ),
        Icon(Icons.done, color: Colors.white, size: 11)
      ],
    ),
  );
}

void _showPopupUpdatePicture(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(AppLocalizations.of(context)!.translate('no')!,
          style: TextStyle(color: SOFT_BLUE)));
  Widget continueButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditProfilePicturePage()));
      },
      child: Text(AppLocalizations.of(context)!.translate('yes')!,
          style: TextStyle(color: SOFT_BLUE)));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Text(
      AppLocalizations.of(context)!.translate('edit_profile_picture')!,
      style: TextStyle(fontSize: 18),
    ),
    content: Text(
        AppLocalizations.of(context)!
            .translate('edit_profile_picture_message')!,
        style: TextStyle(fontSize: 13, color: BLACK_GREY)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void versHomePage(BuildContext context) {
  Navigator.of(context).pop();
}
