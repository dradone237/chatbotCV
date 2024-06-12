import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/services/models/competenceModel.dart';
import 'package:ijshopflutter/services/models/cvModel.dart';
import 'package:ijshopflutter/services/models/resumeModel.dart';
import 'package:ijshopflutter/services/models/user.dart';
import 'package:ijshopflutter/ui/cv/historique.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPagePageState createState() => _ChatPagePageState();
}

class _ChatPagePageState extends State<ChatPage> {
  TextEditingController _controllerChat = TextEditingController();
  ApiService apiService =
      ApiService(); // instance d'api service pour les appls reseau
  CancelToken apiToken = CancelToken(); // Token pour annuler les requetes API
  late IO.Socket socket; //  Socket pour la communication en temps réel.

  bool _isButtonEnabled = false; // Indicateur si le bouton est activé ou non.
  CvModel cvModel = CvModel(); // Modèle pour les données de CV.
  ResumeModel resumeModel = ResumeModel();
  CompetenceModel competenceModel =
      CompetenceModel(); // Modèle pour les données de compétences.
  User user = User(); // Utilisateur connecté.
  bool loadingResume = false; // Indicateur de chargement pour le résumé.
  bool loadingCv = false;
  bool loadingPlan = false;
  bool loadingCompetence = false;
  List<String> chatMessages = []; // Liste des messages de chat.

  @override
  void initState() {
    super.initState();
    //chargeChatMessages(); // Charge les messages de chat depuis les préférences partagées.
    initializeSocket(); // Initialise la connexion socket.
    getConnectedUser(); // Récupère l'utilisateur connecté et ses informations
    listenEvents(); // Écoute les événements socket.
  }

  void listenEvents() {
    // Écoute les événements de suggestion de compétences
    try {
      socket.on('CompetenceSuggestionEvent', (donnees) async {
        setState(() {
          loadingCompetence = false; //// Arrête le chargement des compétences.
        });
        competenceModel = CompetenceModel.fromJson(json.decode(
            donnees)); // Décode les données reçues et met à jour le modèle de compétences.
        DateTime now = DateTime.now();
        String messageTime = DateFormat.Hm().format(now);
        String messageDate = DateFormat.yMd().format(now);

        setState(() {
          chatMessages.insert(0,
              "competenceModel"); //Il met à jour l'état de l'interface utilisateur en insérant un nouveau message "competenceModel" au début de la liste des messages de chat (chatMessages). Ensuite, il efface le contenu du champ de texte où les utilisateurs saisissent leurs messages en utilisant _controllerChat.clear().
          _controllerChat.clear();
        });

        // SharedPreferences prefs = await SharedPreferences
        //     .getInstance(); // Sauvegarde les messages de chat.
        // await prefs.setStringList('chat_messages', chatMessages);
      });
      // Écoute les événements de plan de carrière

      socket.on('planEvent', (donnees) async {
        setState(() {
          loadingPlan = false;
        });
        print(donnees);
        cvModel = CvModel.fromJson(json.decode(donnees));
        DateTime now = DateTime.now();
        String messageTime = DateFormat.Hm().format(
            now); // Obtient la date et l'heure actuelles (now) et formate l'heure (messageTime) et la date (messageDate) au format souhaité.
        String messageDate = DateFormat.yMd().format(now);

        setState(() {
          chatMessages.insert(0,
              "cvModel"); //Il met à jour l'état de l'interface utilisateur en insérant un nouveau message "cvModel" au début de la liste des messages de chat (chatMessages). Ensuite, il efface le contenu du champ de texte où les utilisateurs saisissent leurs messages en utilisant _controllerChat.clear(
          _controllerChat.clear();
        });

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setStringList('chat_messages', chatMessages);
      });

      // Écoute les événements de résumé

      socket.on('resumeEvent', (resiltat) async {
        setState(() {
          loadingResume = false; // Arrête le chargement du résumé.
        });
        print(resiltat);
        //resumeModel = ResumeModel.fromJson(json.decode(resiltat));
        DateTime now = DateTime.now();
        String messageTime = DateFormat.Hm().format(now);
        String messageDate = DateFormat.yMd().format(now);

        setState(() {
          //chatMessages.insert(0, "resumeModel");
          chatMessages.insert(0,
              "$resiltat\n$messageDate - $messageTime"); // Il met à jour l'état de l'interface utilisateur en insérant un nouveau message contenant la variable $resiltat (résultat) suivi de la date et de l'heure ($messageDate - $messageTime) au début de la liste des messages de chat (chatMessages). Ensuite, il efface le contenu du champ de texte où les utilisateurs saisissent leurs messages en utilisant _controllerChat.clear().
          _controllerChat.clear();
        });

        // SharedPreferences prefs = await SharedPreferences
        //     .getInstance(); // Sauvegarde les messages de chat.
        // await prefs.setStringList('chat_messages', chatMessages);
      });
    } catch (e) {
      print(e);
      print("lllllllllllllllllllllllllllllllllllllllll");
    }
  }

  Future<User> getConnectedUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("jjjjjjjhhhhhrecuperation avec sucess");
      print(prefs.getString("currentUser"));
      final userPref = json.decode(prefs.getString("currentUser") ?? '{}');
      print(userPref);

      user = User.fromJson(
          userPref); // Initialise l'utilisateur avec les données récupérées.

      print(user.toJson());
      setState(() {});
    } on Exception catch (error) {
      debugPrint(error.toString());
    }

    return user;
  }

  void initializeSocket() {
    socket = IO.io(BASE_URL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });

    socket.onDisconnect((_) => print('disconnect'));

    socket.connect();
  }

  // void chargeChatMessages() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   chatMessages = prefs.getStringList('chat_messages') ?? [];
  //   setState(() {});
  // }

  @override
  void dispose() {
    _controllerChat.dispose();
    socket.dispose();
    super.dispose();
  }

  // saveuserinfos(String content) async {
  //   try {
  //     final data = {
  //       "messages": [
  //         {"role": "system", "content": "Always answer in rhymes."},
  //         {"role": "user", "content": content}
  //       ],
  //       "temperature": 0.7,
  //       "max_tokens": -1,
  //       "stream": false
  //     };
  //     final response = await apiService.saveuserinfoschat(data, apiToken);
  //     String message = response["choices"][0]["message"]["content"];

  //     DateTime now = DateTime.now();
  //     String messageTime = DateFormat.Hm().format(now);
  //     String messageDate = DateFormat.yMd().format(now);

  //     setState(() {
  //       chatMessages.insert(0, "$message\n$messageDate - $messageTime");
  //       //chatMessages.insert(1, "$content\n$messageDate - $messageTime");
  //       _controllerChat.clear();
  //     });

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setStringList('chat_messages', chatMessages);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void clearChatMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chat_messages');
    setState(() {
      chatMessages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHAT',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 103, 99, 99),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                String message = chatMessages[index];
                bool isUserMessage = index % 2 == 0;

                Color backgroundColor = isUserMessage
                    ? Color.fromARGB(255, 28, 63, 29)
                    : Color.fromARGB(255, 8, 19, 29);
                Color textColor = isUserMessage ? Colors.white : Colors.white;
                if (chatMessages[index] == 'cvModel') {
                  return Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exemple de Plan de Carrière Pour votre Donnaine est:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Affichage du plan de carrière
                        if (cvModel.planCarriers != null &&
                            cvModel.planCarriers!.isNotEmpty)
                          ...cvModel.planCarriers!.map((planCarrier) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  planCarrier.poste ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                if (planCarrier.description != null)
                                  Text(
                                    'Description : ${planCarrier.description}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                if (planCarrier.competenceRequises != null &&
                                    planCarrier
                                        .competenceRequises!.isNotEmpty) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    'Compétences requises :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ...planCarrier.competenceRequises!
                                      .map((competence) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text('• $competence'),
                                          ))
                                      .toList(),
                                ],
                                if (planCarrier.centreFormation != null &&
                                    planCarrier
                                        .centreFormation!.isNotEmpty) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    'Centre de formation :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ...planCarrier.centreFormation!
                                      .map((centre) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text('• $centre'),
                                          ))
                                      .toList(),
                                ],
                                if (planCarrier.certification != null &&
                                    planCarrier.certification!.isNotEmpty) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    'Certifications :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ...planCarrier.certification!
                                      .map((certif) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text('• $certif'),
                                          ))
                                      .toList(),
                                ],
                                Divider(color: Colors.grey), // Séparateur
                                SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                      ],
                    ),
                  );
                }

                if (chatMessages[index] == 'competenceModel') {
                  return Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Compétences Requises Pour Votre Donnaine est : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Affichage des compétences requises
                        if (competenceModel.competences != null &&
                            competenceModel.competences!.isNotEmpty)
                          ...competenceModel.competences!.map((competence) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  competence.nomCompetence ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                if (competence.justification != null)
                                  Text(
                                    'Justification : ${competence.justification}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                if (competence.lieuFormation != null &&
                                    competence.lieuFormation!.isNotEmpty) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    'Lieu de formation :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ...competence.lieuFormation!
                                      .map((lieu) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text('• $lieu'),
                                          ))
                                      .toList(),
                                ],
                                Divider(color: Colors.grey), // Séparateur
                                SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                      ],
                    ),
                  );
                }
                // if (chatMessages[index] == 'resumeModel') {
                //   return Container(
                //     padding: EdgeInsets.all(15),
                //     margin: EdgeInsets.symmetric(vertical: 10),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5),
                //           spreadRadius: 2,
                //           blurRadius: 5,
                //           offset: Offset(0, 3),
                //         ),
                //       ],
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Résumé:',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //             color: Colors.blue,
                //           ),
                //         ),
                //         SizedBox(height: 10),
                //         // Affichage du résumé
                //         if (resumeModel.resumes != null &&
                //             resumeModel.resumes!.isNotEmpty)
                //           ...resumeModel.resumes!.map((resume) {
                //             return Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   resume.titre ?? '',
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 16,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 if (resume.description != null)
                //                   Text(
                //                     'Description : ${resume.description}',
                //                     style: TextStyle(color: Colors.grey),
                //                   ),
                //                 if (resume.periode != null)
                //                   Text(
                //                     'Période : ${resume.periode}',
                //                     style: TextStyle(color: Colors.grey),
                //                   ),
                //                 Divider(color: Colors.grey), // Séparateur
                //                 SizedBox(height: 10),
                //               ],
                //             );
                //           }).toList(),
                //       ],
                //     ),
                //   );
                // }

                return Align(
                  alignment:
                      isUserMessage ? Alignment.topRight : Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(55.0),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message,
                            style: TextStyle(
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle: TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(70.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 30.0,
                ),
                isCollapsed: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: loadingResume ||
                          loadingCv ||
                          loadingPlan ||
                          loadingCompetence
                      ? CircularProgressIndicator(
                          color: Colors.orange,
                        )
                      : _buildCircularButton(context),
                ),
              ),
              controller: _controllerChat,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  _isButtonEnabled = value.length >= 5;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showOptionsDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              _isButtonEnabled ? Colors.orange : Colors.orange.withOpacity(0.5),
        ),
        child: Icon(
          Icons.menu,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: loadingResume
                    ? CircularProgressIndicator()
                    : Text('Résumé'),
                tileColor: Colors.blueAccent, // Couleur de fond
                onTap: loadingResume
                    ? null
                    : () {
                        setState(() {
                          loadingResume = true;
                        });
                        int? users = user.userId;
                        socket.emit('resumeClientEvent', {users});

                        Navigator.pop(context);
                      },
              ),
              ListTile(
                title: loadingCv
                    ? CircularProgressIndicator()
                    : Text('CV Utilisateur'),
                tileColor: Colors.greenAccent, // Couleur de fond
                onTap: loadingCv
                    ? null
                    : () async {
                        setState(() {
                          loadingCv = true;
                        });
                        String jobDescription = _controllerChat.text;
                        int? userId = user.userId;
                        print(userId);

                        socket.emit('cvLocalClientEvent', {
                          'userId': userId,
                          'jobDescription': jobDescription,
                        });

                        // Ajouter un délai de 15 secondes avant la navigation
                        await Future.delayed(Duration(seconds: 15));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CvHistoryPage(),
                          ),
                        );

                        socket.on('localCvEvent', (data) {
                          setState(() {
                            loadingCv = false;
                          });
                        });
                      },
              ),
              ListTile(
                title: loadingPlan
                    ? CircularProgressIndicator()
                    : Text('Plan de Carrière'),
                tileColor: Colors.orangeAccent, // Couleur de fond
                onTap: loadingPlan
                    ? null
                    : () {
                        setState(() {
                          loadingPlan = true;
                        });
                        int? userId = user.userId;
                        String domaine = _controllerChat.text;
                        socket.emit('planClientEvent',
                            {'userId': userId, 'domaine': domaine});
                        // fonction socket
                        Navigator.pop(context);
                      },
              ),
              ListTile(
                title: loadingCompetence
                    ? CircularProgressIndicator()
                    : Text('Suggestion de Compétences'),
                tileColor: Colors.purpleAccent, // Couleur de fond
                onTap: loadingCompetence
                    ? null
                    : () {
                        setState(() {
                          loadingCompetence = true;
                        });
                        int? userId = user.userId;
                        socket.emit('CompetenceSuggestionClientEvent',
                            {'userId': userId});

                        Navigator.pop(context);
                      },
              ),
              ListTile(
                title: Text('Effacer la conversation'),
                tileColor: Colors.redAccent, // Couleur de fond
                onTap: () {
                  clearChatMessages();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// /*
// This is wishlist page
// we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime

// include file in reuseable/global_function.dart to call function from GlobalFunction
// include file in reuseable/global_widget.dart to call function from GlobalWidget
// include file in reuseable/cache_image_network.dart to use cache image network
// include file in reuseable/shimmer_loading.dart to use shimmer loading
// include file in model/wishlist/wishlist_model.dart to get wishlistData

// install plugin in pubspec.yaml
// - fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

// Don't forget to add all images and sound used in this pages at the pubspec.yaml
//  */

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ijshopflutter/bloc/wishlist/bloc.dart';
// import 'package:ijshopflutter/config/constants.dart';
// import 'package:ijshopflutter/config/global_style.dart';
// import 'package:ijshopflutter/model/activity/activity_model.dart';
// import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';
// import 'package:ijshopflutter/ui/activity/create_activity.dart';
// import 'package:ijshopflutter/ui/general/activity_detail/Activity_detail.dart';
// import 'package:ijshopflutter/ui/general/chat_us.dart';
// import 'package:ijshopflutter/ui/general/notification.dart';
// import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
// import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
// import 'package:ijshopflutter/ui/reuseable/global_function.dart';
// import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
// import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

// class ActivityPage extends StatefulWidget {
//   ActivityPage(

//       // ActivityModel activity

//       );

//   @override
//   _ActivityPageState createState() => _ActivityPageState();
// }

// class _ActivityPageState extends State<ActivityPage>
//     with AutomaticKeepAliveClientMixin {
//   // initialize global function, global widget and shimmer loading
//   final _globalFunction = GlobalFunction();
//   final _globalWidget = GlobalWidget();
//   final _shimmerLoading = ShimmerLoading();

//   List<WishlistModel> wishlistData = [];
//   List<ActivityModel> activityData = [
//     ActivityModel(
//         id: 1,
//         title: "meli",
//         image: "image",
//         review: 3,
//         printFormat: "New",
//         service: "saisir",
//         selectedLanguage: " "),
//     ActivityModel(
//         id: 1,
//         title: "impression",
//         image: "image",
//         review: 3,
//         printFormat: "In Progress",
//         service: "impresion",
//         selectedLanguage: " "),
//     ActivityModel(
//         id: 1,
//         title: "saisir",
//         image: "image",
//         review: 3,
//         printFormat: "In Progress",
//         service: "impression",
//         selectedLanguage: " "),
//     ActivityModel(
//         id: 1,
//         title: "saisir",
//         image: "image",
//         review: 3,
//         printFormat: "In Progress",
//         service: "impression",
//         selectedLanguage: " "),
//   ];

//   late WishlistBloc _wishlistBloc;
//   bool _lastData = false;

//   CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

//   // _listKey is used for AnimatedList
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey();

//   TextEditingController _etSearch = TextEditingController();

//   // keep the state to do not refresh when switch navbar
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     // get data when initState
//     _wishlistBloc = BlocProvider.of<WishlistBloc>(context);
//     _wishlistBloc.add(GetWishlist(sessionId: SESSION_ID, apiToken: apiToken));

//     super.initState();
//   }

//   @override
//   void dispose() {
//     apiToken.cancel("cancelled"); // cancel fetch data from API
//     _etSearch.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
//     super.build(context);
//     final double boxImageSize = (MediaQuery.of(context).size.width / 4);
//     return Scaffold(
//         appBar: AppBar(
//           elevation: GlobalStyle.appBarElevation,
//           title: Text(
//             AppLocalizations.of(context)!.translate('wishlist')!,
//             style: GlobalStyle.appBarTitle,
//           ),
//           backgroundColor: GlobalStyle.appBarBackgroundColor,
//           systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
//           actions: [
//             GestureDetector(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => ChatUsPage()));
//                 },
//                 child: Icon(Icons.email, color: BLACK_GREY)),
//             IconButton(
//                 icon: _globalWidget.customNotifIcon(8, BLACK_GREY),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => NotificationPage()));
//                 }),
//           ],
//           // create search text field in the app bar
//           bottom: PreferredSize(
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                     bottom: BorderSide(
//                   color: Colors.grey[100]!,
//                   width: 1.0,
//                 )),
//               ),
//               padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
//               height: kToolbarHeight,
//               child: TextFormField(
//                 controller: _etSearch,
//                 textAlignVertical: TextAlignVertical.bottom,
//                 maxLines: 1,
//                 style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 onChanged: (textValue) {
//                   setState(() {});
//                 },
//                 decoration: InputDecoration(
//                   fillColor: Colors.grey[100],
//                   filled: true,
//                   hintText: AppLocalizations.of(context)!
//                       .translate('search_activity')!,
//                   prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
//                   suffixIcon: (_etSearch.text == '')
//                       ? null
//                       : GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _etSearch = TextEditingController(text: '');
//                             });
//                           },
//                           child: Icon(Icons.close, color: Colors.grey[500])),
//                   focusedBorder: UnderlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       borderSide: BorderSide(color: Colors.grey[200]!)),
//                   enabledBorder: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     borderSide: BorderSide(color: Colors.grey[200]!),
//                   ),
//                 ),
//               ),
//             ),
//             preferredSize: Size.fromHeight(kToolbarHeight),
//           ),
//         ),
//         floatingActionButton: buildNavigationButton(),
//         body: RefreshIndicator(
//           onRefresh: refreshData,
//           child: BlocListener<WishlistBloc, WishlistState>(
//             listener: (context, state) {
//               if (state is WishlistError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetWishlistSuccess) {
//                 if (state.wishlistData.length == 0) {
//                   _lastData = true;
//                 } else {
//                   wishlistData.addAll(state.wishlistData);
//                 }
//               }
//             },
//             child: BlocBuilder<WishlistBloc, WishlistState>(
//               builder: (context, state) {
//                 if (state is WishlistError) {
//                   return Container(
//                       child: Center(
//                           child: Text(ERROR_OCCURED,
//                               style:
//                                   TextStyle(fontSize: 14, color: BLACK_GREY))));
//                 } else {
//                   if (_lastData) {
//                     return Container(
//                         child: Center(
//                             child: Text(
//                                 AppLocalizations.of(context)!
//                                     .translate('no_activity')!,
//                                 style: TextStyle(
//                                     fontSize: 14, color: BLACK_GREY))));
//                   } else {
//                     if (activityData.length == 0) {
//                       return _shimmerLoading.buildShimmerContent();
//                     } else {
//                       return AnimatedList(
//                         key: _listKey,
//                         initialItemCount: activityData.length,
//                         physics: AlwaysScrollableScrollPhysics(),
//                         itemBuilder: (context, index, animation) {
//                           return _buildWishlistCard(activityData[index],
//                               boxImageSize, animation, index);
//                         },
//                       );
//                     }
//                   }
//                 }
//               },
//             ),
//           ),
//         )
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () {},
//         //   backgroundColor: Colors.orangeAccent,
//         //   child: const Icon(Icons.add),
//         //   ),

//         );
//   }

//   Widget _buildWishlistCard(
//       ActivityModel activityData, boxImageSize, animation, index) {
//     return SizeTransition(
//       sizeFactor: animation,
//       child: Container(
//         margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           elevation: 2,
//           color: Colors.white,
//           child: Container(
//             margin: EdgeInsets.all(8),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ActivityDetailPage(
//                                   title: activityData.title,
//                                   image: activityData.image,
//                                   review: activityData.review,
//                                   service: activityData.service,
//                                 )));
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       ClipRRect(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           child: buildCacheNetworkImage(
//                               width: boxImageSize,
//                               height: boxImageSize,
//                               url: activityData.image)),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               activityData.title,
//                               style: GlobalStyle.productName
//                                   .copyWith(fontSize: 13),
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Row(
//                                 children: [
//                                   Text(' ' + activityData.service,
//                                       style: GlobalStyle.productLocation)
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                           .translate('action')! +
//                                       ' ' +
//                                       activityData.service.toString(),
//                                   style: GlobalStyle.productSale),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 12),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         behavior: HitTestBehavior.translucent,
//                         onTap: () {
//                           showPopupDeleteWishlist(index, boxImageSize);
//                         },
//                         child: Container(
//                           padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                           height: 30,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                   width: 1, color: Colors.grey[300]!)),
//                           child:
//                               Icon(Icons.delete, color: BLACK_GREY, size: 20),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildNavigationButton() => FloatingActionButton(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.cyan,
//         onPressed: () {
//           print('pressed');
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CreateActivity()),
//           );
//         },
//       );

//   Future refreshData() async {
//     setState(() {
//       activityData.clear();
//       _wishlistBloc.add(GetWishlist(sessionId: SESSION_ID, apiToken: apiToken));
//     });
//   }

//   void showPopupDeleteWishlist(index, boxImageSize) {
//     // set up the buttons
//     Widget cancelButton = TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: Text(AppLocalizations.of(context)!.translate('no')!,
//             style: TextStyle(color: SOFT_BLUE)));
//     Widget continueButton = TextButton(
//         onPressed: () {
//           int removeIndex = index;
//           var removedItem = activityData.removeAt(removeIndex);
//           // This builder is just so that the animation has something
//           // to work with before it disappears from view since the original
//           // has already been deleted.
//           AnimatedRemovedItemBuilder builder = (context, animation) {
//             // A method to build the Card widget.
//             return _buildWishlistCard(
//                 removedItem, boxImageSize, animation, removeIndex);
//           };
//           _listKey.currentState!.removeItem(removeIndex, builder);

//           Navigator.pop(context);
//           Fluttertoast.showToast(
//               msg: AppLocalizations.of(context)!
//                   .translate('item_deleted_activity')!,
//               toastLength: Toast.LENGTH_LONG);
//         },
//         child: Text(AppLocalizations.of(context)!.translate('yes')!,
//             style: TextStyle(color: SOFT_BLUE)));

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       title: Text(
//         AppLocalizations.of(context)!.translate('delete_activity')!,
//         style: TextStyle(fontSize: 18),
//       ),
//       content: Text(
//           AppLocalizations.of(context)!
//               .translate('are_you_sure_delete_activity')!,
//           style: TextStyle(fontSize: 13, color: BLACK_GREY)),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
