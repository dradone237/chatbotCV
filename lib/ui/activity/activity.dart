import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ApiService apiService = ApiService();
  CancelToken apiToken = CancelToken();

  bool _isButtonEnabled = false;
  bool loading = false;
  List<String> chatMessages = []; // Tableau pour stocker les messages du chat

  @override
  void initState() {
    super.initState();
    chargeChatMessages();
  }

  void chargeChatMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    chatMessages = prefs.getStringList('chat_messages') ?? [];
    setState(() {}); // Actualiser l'interface après avoir chargé les messages
  }

  @override
  void dispose() {
    _controllerChat.dispose();
    super.dispose();
  }

  saveuserinfos(String content) async {
    try {
      final data = {
        "messages": [
          {"role": "system", "content": "Always answer in rhymes."},
          {"role": "user", "content": content}
        ],
        "temperature": 0.7,
        "max_tokens": -1,
        "stream": false
      };
      final response = await apiService.saveuserinfoschat(data, apiToken);
      String message = response["choices"][0]["message"]["content"];

      DateTime now = DateTime.now();
      String messageTime = DateFormat.Hm().format(now);
      String messageDate = DateFormat.yMd().format(now);

      setState(() {
        chatMessages.add("$content\n$messageDate - $messageTime");
        chatMessages.add("$message\n$messageDate - $messageTime");
        _controllerChat.clear();
      });

      // Sauvegarde de la liste de messages dans SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('chat_messages', chatMessages);
    } catch (e) {
      print(e);
    }
  }

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
        title: Text('Bienvenue sur le chat'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: clearChatMessages,
            child: Text('Effacer la conversation '),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                String message = chatMessages[index];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.topRight,
                  child: Text(
                    message,
                    style: TextStyle(
                        color: index.isEven ? Colors.black : Colors.brown),
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
                  child: loading
                      ? CircularProgressIndicator(
                          color: Colors.orange,
                        )
                      : IconButton(
                          icon: Icon(Icons.play_arrow),
                          iconSize: 50,
                          color: _isButtonEnabled
                              ? Colors.orange
                              : Colors.orange.withOpacity(0.5),
                          onPressed: () async {
                            if (_isButtonEnabled) {
                              setState(() {
                                loading = true;
                              });
                              await saveuserinfos(_controllerChat.text);
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        ),
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
