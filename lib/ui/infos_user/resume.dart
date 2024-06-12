// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:ijshopflutter/services/network/api_service.dart';
// import 'package:ijshopflutter/ui/account/competences.dart';
// import 'package:ijshopflutter/ui/account/loisir.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ResunePage(),
//     );
//   }
// }

// class ResunePage extends StatefulWidget {
//   @override
//   _ResunePageState createState() => _ResunePageState();
// }

// class _ResunePageState extends State<ResunePage> {
//   TextEditingController _controllerResume = TextEditingController();
//   ApiService apiService = ApiService(); // instance de la classe api service
//   CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controllerResume.dispose();
//     super.dispose();
//   }

//   void saveuserinfosresume(String resume) {
//     try {
//       final data = {
//         'resume': resume,
//       };
//       final response = apiService.saveuserinfosresume(data, apiToken);
//       print(response);

//       // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => LoisirPage()));
//     } catch (e) {
//       print(e);
//       print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
//     }
//   }

//   DateTime? date;
//   var currentOption = 0; // Pour la première option
//   var options = [0, 1]; // Les valeurs pour les boutons radio

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'RESUME',
//           style: TextStyle(
//             color: Colors.white, // Couleur du texte
//           ),
//         ),
//         backgroundColor:
//             Colors.blue, // Couleur de l'arrière-plan de la barre d'appBar
//         automaticallyImplyLeading:
//             false, // Pour ne pas afficher la flèche de retour
//         centerTitle: true, // Pour centrer le titre de la page
//       ),
//       body: ListView(
//         children: <Widget>[
//           SizedBox(height: 120),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'REDIGEZ UNE SYNTHESE PROFESSIONNELLE ',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Entrez votre synthese ',
//                         labelStyle: TextStyle(fontSize: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                       controller: _controllerResume,
//                       keyboardType: TextInputType.text,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 300),
//                 Container(
//                   color: Colors.blue,
//                   width: double.infinity,
//                   height: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           versCompetencesPage(context);

//                           // Action à effectuer lors du clic sur le bouton "Suivant"
//                         },
//                         child: Text('Retour',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20)),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
//                           saveuserinfosresume(
//                             _controllerResume.text,
//                           );
//                           //versLoisirPage(context);
//                           // Action à effectuer lors du clic sur le bouton "Retour"
//                         },
//                         child: Text('Suivant',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20)),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void versCompetencesPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => CompetencesPage(),
//     ),
//   );
// }

// void versLoisirPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => LoisirPage(),
//     ),
//   );
// }
