/*
This is signin page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
//import 'package:ijshopflutter/ui/authentication/signin/signin_email.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin_phone_number_choose_verification.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup.dart';
import 'package:ijshopflutter/ui/home/home1.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../signup/signup_phone_number_verification.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  bool _phoneValid = false;
  bool _passwordValid = false;
  String _validate = '';
  late int phoneNumber;
  late int pin_code;

  // String initialCountry = 'CM';
  //honeNumber number = PhoneNumber(isoCode: 'CM');
  String phone = " ";

  // gestion du controle des champs de text

  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerPincode = TextEditingController();

  // creation et utilisation de la classe ApiService

  ApiService apiService =
      ApiService(); // instance de la classe api service, pour pourvois utlise la classe API service dans ce fichier il est necessaire de creer une inatance de cette classe dans le fichier ou on veux utilise
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // cette fonction est la premiere fonction qui est lance a l'overture d'une page
    super.initState();
    //checkAuthStatus(context);
    autoConnect(
        context); // cette est utilise pour verifier si l'utilisateur c'est deja connecte si c'est oui il serais diriger directement vers la page principale qui la page home
  }

  @override
  void dispose() {
    // cette fonction est appelle lors de la fermerture de la page

    _controllerPhoneNumber.dispose();
    _controllerPincode.dispose();
    super.dispose();
  }

  // //  cette fonction est avec la libraie SharedPreferences pour realise le stokage dans le store de l'application pour la connexion
  // ignore: unused_element
  void _saveData(int phoneNumber, int pin_code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('phoneNumber', phoneNumber);
    await prefs.setInt('pin_code', pin_code);
  }

  void signin({String? phoneNumber, String? password}) async {
    // la fonction signin prends en paramettre le numero de telephne et le mot de passe
    // ici notre fonction signin prends seulement en parametre le password de type String ou null car La présence du symbole ? après le type String indique que le paramètre peut être null.
    try {
      final data = {
        //creation de l'objet data qui va nous permettre t'envoie les donnees a partir L'API
        'telephone': phone.substring(
            4), // la fonction substring permet de retire le +237 devant le numero
        'password': password,
      };
      print(data);

      // la variable response va recupere le resultat de l'objet data de  la requette  login  de l'API
      final response = await apiService.login(data,
          apiToken); //cette ligne permet de faire un appel vers l'APi,pour realise cette ligne il faut creer une variable apiToken, pour ce fais dans la page home faire ctrl + f et recherche apiToken et copier cette ligne qui contient apiToken et le coller apres la ligne qui nous permet de creer une instance de notre class et faire les inportation
      print(response);
      // si le login c'est bien passe car l'utilisateur a bien entre les informations puis l'utiliateur seras rediriger directemment dans le menu principal c'est dire la page Home en cliquan sur le boutton navigation
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    } catch (e) {
      print(e);
    }
  }

  void autoConnect(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isAuth = prefs.getBool('isAuth') ?? false;
      print(isAuth);
      if (isAuth) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
      }
    } catch (e) {
      print(
          'Erreur lors de la vérification du statut de connexion: $e: ${e.toString()}');
    }
  }

  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'CM');

  //   setState(() {
  //     this.phone = number.phoneNumber ?? "";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
      children: <Widget>[
        Center(child: Image.asset('assets/images/logo_light.png', height: 120)),
        SizedBox(
          height: 0,
        ),
        Text('Se connecter: ', style: GlobalStyle.authTitle),
        SizedBox(
          height: 0,
        ),

        InternationalPhoneNumberInput(
          onInputValidated: (value) {
            print(value);
            _phoneValid = !value;
            setState(() {
              if (value) {
                _buttonDisabled = false;
                _validate = 'phone_number';
              } else {
                _buttonDisabled = true;
              }
            });
          },
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
            setState(() {
              phone = number.phoneNumber ?? "";
            });
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          initialValue: PhoneNumber(
            phoneNumber: '',
            isoCode: 'CM',
          ),
          inputDecoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: (''),
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),

// Ajoutez ce Text widget pour afficher le message d'erreur
        Visibility(
          visible:
              _phoneValid, // Assuming you want to show the error when the phone number is invalid
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center align the Row
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.yellow,
                      size: 24,
                    ),
                    Text(
                      '!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8), // Adds space between the icon and the text
                Text(
                  'Please enter a valid phone number!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 5,
        ),

        // creation du champ de saisie pour le mot de passe
        TextFormField(
          keyboardType: TextInputType.text,
          controller: _controllerPincode,
          style: TextStyle(color: CHARCOAL),
          onTap: () {
            setState(() {
              // Efface le message d'erreur lorsque l'utilisateur clique sur le champ de mot de passe
              _passwordValid = false;
            });
          },
          onChanged: (textValue) {
            setState(() {
              if (_globalFunction.validateMobileNumber(textValue)) {
                _buttonDisabled = true;
                _validate = 'pin_code';
              } else {
                _buttonDisabled = false;
              }
            });
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            labelText: 'Mot de passe: ',
            labelStyle: TextStyle(color: BLACK_GREY),
          ),
        ),
        // Affichage du message d'erreur pour le champ de mot de passe en bas du champ
        Visibility(
          visible:
              _passwordValid, // Assuming you want to show the error when the phone number is invalid
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center align the Row
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.yellow,
                      size: 24,
                    ),
                    Text(
                      '!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8), // Adds space between the icon and the text
                Text(
                  'password must be at least 8 caracteres!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.translate('example')! + ' : ',
                style: GlobalStyle.authNotes,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Teranova12', style: GlobalStyle.authNotes),
                ],
              )
            ],
          ),
        ),

        SizedBox(
          height: 10,
        ),

        Text(
          'mot de passe  oublie ?',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.right,
        ),

        SizedBox(
          height: 50,
        ),

        // creation du boutton Next avec ses differentes apparence en fonction de son etat active ou desactive
        Container(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.disabled)
                        ? Colors.grey[300]!
                        : _buttonDisabled
                            ? Colors.grey[300]!
                            : PRIMARY_COLOR,
              ),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              )),
            ),
            onPressed: () {
              // Vérifie si le numéro de téléphone est valide et si le mot de passe n'est pas vide
              if (!_buttonDisabled && _controllerPincode.text.isNotEmpty) {
                if (_controllerPincode.text.length >= 8) {
                  signin(
                    phoneNumber: _controllerPhoneNumber.text,
                    password: _controllerPincode.text,
                  );
                } else {
                  // Affiche un message d'erreur si le mot de passe est invalide
                  setState(() {
                    _passwordValid = true;
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _buttonDisabled ? Colors.grey[600] : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        SizedBox(
          height: 50,
        ),

        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
              FocusScope.of(context).unfocus();
            },
            child: Wrap(
              children: [
                Text(
                  'pas encore de compte ?',
                  style: GlobalStyle.authBottom1,
                ),
                Text(
                  'Creez-en un !',
                  style: GlobalStyle.authBottom2,
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
