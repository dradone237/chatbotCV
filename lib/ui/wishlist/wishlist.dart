import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_profile_picture.dart';
import 'package:ijshopflutter/ui/home/home1.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import '../infos_user/education.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PreferencesPage(),
    );
  }
}

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
        title: Text('Preferences'),
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
                          Navigator.of(context).pop();
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
// import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';
// import 'package:ijshopflutter/ui/general/chat_us.dart';
// import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
// import 'package:ijshopflutter/ui/general/notification.dart';
// import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
// import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
// import 'package:ijshopflutter/ui/reuseable/global_function.dart';
// import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
// import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';
// //import 'package:percent_indicator/percent_indicator.dart';

// class WishlistPage extends StatefulWidget {
//   @override
//   _WishlistPageState createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage>
//     with AutomaticKeepAliveClientMixin {
//   // initialize global function, global widget and shimmer loading
//   final _globalFunction = GlobalFunction();
//   final _globalWidget = GlobalWidget();
//   final _shimmerLoading = ShimmerLoading();

//   List<WishlistModel> wishlistData = [];

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
//             AppLocalizations.of(context)!.translate('activities')!,
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
//                       .translate('Search Activity')!,
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
//                                     .translate('no_wishlist')!,
//                                 style: TextStyle(
//                                     fontSize: 14, color: BLACK_GREY))));
//                   } else {
//                     if (wishlistData.length == 0) {
//                       return _shimmerLoading.buildShimmerContent();
//                     } else {
//                       return AnimatedList(
//                         key: _listKey,
//                         initialItemCount: wishlistData.length,
//                         physics: AlwaysScrollableScrollPhysics(),
//                         itemBuilder: (context, index, animation) {
//                           return _buildWishlistCard(wishlistData[index],
//                               boxImageSize, animation, index);
//                         },
//                       );
//                     }
//                   }
//                 }
//               },
//             ),
//           ),
//         ));
//   }

//   Widget _buildWishlistCard(
//       WishlistModel wishlistData, boxImageSize, animation, index) {
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
//                             builder: (context) => ProductDetailPage(
//                                 name: wishlistData.name,
//                                 image: wishlistData.image,
//                                 price: wishlistData.price,
//                                 rating: wishlistData.rating,
//                                 review: wishlistData.review,
//                                 sale: wishlistData.sale)));
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
//                               url: wishlistData.image)),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               wishlistData.name,
//                               style: GlobalStyle.productName
//                                   .copyWith(fontSize: 13),
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Text(
//                                   '\$ ' +
//                                       _globalFunction.removeDecimalZeroFormat(
//                                           wishlistData.price),
//                                   style: GlobalStyle.productPrice),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.location_on,
//                                       color: SOFT_GREY, size: 12),
//                                   Text(' ' + wishlistData.location,
//                                       style: GlobalStyle.productLocation)
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Row(
//                                 children: [
//                                   _globalWidget
//                                       .createRatingBar(wishlistData.rating),
//                                   Text(
//                                       '(' +
//                                           wishlistData.review.toString() +
//                                           ')',
//                                       style: GlobalStyle.productTotalReview)
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Text(
//                                   wishlistData.sale.toString() +
//                                       ' ' +
//                                       AppLocalizations.of(context)!
//                                           .translate('sale')!,
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
//                       Expanded(
//                         child: (wishlistData.stock == 0)
//                             ? TextButton(
//                                 style: ButtonStyle(
//                                   minimumSize:
//                                       MaterialStateProperty.all(Size(0, 30)),
//                                   backgroundColor:
//                                       MaterialStateProperty.resolveWith<Color>(
//                                     (Set<MaterialState> states) =>
//                                         Colors.grey[300]!,
//                                   ),
//                                   overlayColor: MaterialStateProperty.all(
//                                       Colors.transparent),
//                                   shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   )),
//                                 ),
//                                 onPressed: null,
//                                 child: Text(
//                                   AppLocalizations.of(context)!
//                                       .translate('out_of_stock')!,
//                                   style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 13),
//                                   textAlign: TextAlign.center,
//                                 ))
//                             : OutlinedButton(
//                                 onPressed: () {
//                                   Fluttertoast.showToast(
//                                       msg: AppLocalizations.of(context)!
//                                           .translate('shopping_cart_added')!,
//                                       toastLength: Toast.LENGTH_LONG);
//                                 },
//                                 style: ButtonStyle(
//                                     minimumSize:
//                                         MaterialStateProperty.all(Size(0, 30)),
//                                     overlayColor: MaterialStateProperty.all(
//                                         Colors.transparent),
//                                     shape: MaterialStateProperty.all(
//                                         RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                     )),
//                                     side: MaterialStateProperty.all(
//                                       BorderSide(color: SOFT_BLUE, width: 1.0),
//                                     )),
//                                 child: Text(
//                                   AppLocalizations.of(context)!
//                                       .translate('add_to_shopping_cart')!,
//                                   style: TextStyle(
//                                       color: SOFT_BLUE,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 13),
//                                   textAlign: TextAlign.center,
//                                 )),
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

//   Future refreshData() async {
//     setState(() {
//       wishlistData.clear();
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
//           var removedItem = wishlistData.removeAt(removeIndex);
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
//                   .translate('item_deleted_wishlist')!,
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
//         AppLocalizations.of(context)!.translate('delete_wishlist')!,
//         style: TextStyle(fontSize: 18),
//       ),
//       content: Text(
//           AppLocalizations.of(context)!
//               .translate('are_you_sure_delete_wishlist')!,
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
