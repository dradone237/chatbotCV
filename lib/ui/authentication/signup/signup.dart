/*
This is signup page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_phone_number_verification.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_email_choose_verification.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_phone_number_choose_verification.dart';
import 'package:ijshopflutter/ui/home/home1.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/network/api_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  bool _phoneValid = false;
  bool _passwordValid = false;
  String _validate = '';
  String phone = " ";

  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerPincode = TextEditingController();

  // creation et utilisation de la classe ApiService  et inportation des des differents packages
  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    super.initState();
    autoCompte(context);
  }

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerPincode.dispose();
    super.dispose();
  }

  //  cette fonction est avec la libraie SharedPreferences pour realise le stokage dans le store de l'application pour le sign up
  void autoCompte(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hasAccount = prefs.getBool('hasAccount') ?? false;

    if (hasAccount) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    }
  }

  void signup(String? phoneNumber, String? password) {
    try {
      final data = {
        'telephone': phone.substring(4),
        'password': password,
      };
      final response = apiService.signup(data, apiToken);
      print(response);

      // si  le sign up  c'est bien passe car l'utilisateur a bien entre les informations puis l'utiliateur seras rediriger directemment dans le menu principale qui est le boutton navigation
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SigninPage()));
    } catch (e) {
      print(e);
    }
  }

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
        Text(("S'inscrire"), style: GlobalStyle.authTitle),

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
            isoCode: 'CM', // ISO code for Cameroon
          ),
          inputDecoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            labelText: (''),
            labelStyle: TextStyle(color: BLACK_GREY),
          ),
        ),
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

// Affichage du message d'erreur pour le champ de mot de passe en dessous du champ
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

        SizedBox(height: 80),
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
                if (!_buttonDisabled && _controllerPincode.text.isNotEmpty) {
                  // Vérifie la validité du mot de passe
                  if (_controllerPincode.text.length >= 8) {
                    signup(
                      _controllerPhoneNumber.text,
                      _controllerPincode.text,
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
                  AppLocalizations.of(context)!.translate('register')!,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _buttonDisabled ? Colors.grey[600] : Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
        ),

        SizedBox(
          height: 100,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child: Wrap(
              children: [
                Text(
                  ('Deja menbre ?'),
                  style: GlobalStyle.authBottom1,
                ),
                Text(
                  'Connexion',
                  style: GlobalStyle.authBottom2,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Créez rapidement votre CV grâce à la puissance de l\'IA',
                  style: GlobalStyle
                      .authBottom1, // Vous pouvez utiliser un autre style si nécessaire
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
