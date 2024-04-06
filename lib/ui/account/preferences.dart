import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_profile_picture.dart';
import 'package:ijshopflutter/ui/home/home1.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'education.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PreferencesPage(),
//     );
//   }
// }

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
// initialisation de la fonction globale
  //final _globalFunction = GlobalFunction();

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

  void saveuserinfosperso(
      String nom,
      String prenom,
      String profession,
      String sexe,
      String nationalite,
      String email,
      String adresse,
      String dateNaissance) {
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

  // DateTime? date;
  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infos Personnel'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 150),
          _createProfilePicture(context),
          SizedBox(height: 80),
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
                TextFormField(
                  readOnly: true,
                  //controller: _controllerNationalite,
                  controller: TextEditingController(text: selectedCountry),
                  decoration: InputDecoration(
                    labelText: 'nationalite',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onTap: () {
                    _showCountryPicker(context);
                  },
                  onChanged: (textValue) {},
                ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'pays'),
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
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
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                      onChanged: (textValue) {},
                    ),
                  ],
                ),
                // FloatingActionButton.extended(
                //   label: Text((date == null) ? '30/03/1990' : date.toString()),
                //   onPressed: montrerDate,
                // ),
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

                // Row(
                //   children: [
                //     Radio(
                //       value: options[0],
                //       groupValue: currentOption,
                //       onChanged: (value) {
                //         setState(() {
                //           currentOption = value!;
                //         });
                //       },
                //     ),
                //     Text(
                //       'Homme',
                //       style: TextStyle(
                //           fontSize: 20), // Taille du texte pour "Homme"
                //     ),
                //     Radio(
                //       value: options[1],
                //       groupValue: currentOption,
                //       onChanged: (value) {
                //         setState(() {
                //           currentOption = value!;
                //         });
                //       },
                //     ),
                //     Text(
                //       'Femme',
                //       style: TextStyle(
                //           fontSize: 20), // Taille du texte pour "femme "
                //     ),
                //   ],
                // ),

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
                          // if (!_buttonDisabled) {
                          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
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

                          //versEducationPage(context);

                          //}
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

  // Future<void> montrerDate() async {
  //   DateTime? choix = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1990),
  //     lastDate: DateTime(2045),
  //   );
  //   if (choix != null) {
  //     setState(() {
  //       date = choix;
  //     });
  //   }
  // }
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
                        url: GLOBAL_URL + '/user/avatar.png')),
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
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );
}
