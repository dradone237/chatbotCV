/*
This is edit profile picture page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)
- image_picker => to pick image from storage or camera (https://pub.dev/packages/image_picker)
  add this to ios Info.plist
  <key>NSPhotoLibraryUsageDescription</key>
  <string>I need this permission to test upload photo</string>
  <key>NSCameraUsageDescription</key>
  <string>I need this permission to test upload photo</string>
  <key>NSMicrophoneUsageDescription</key>
  <string>I need this permission to test upload photo</string>

- image_cropper => to crop the image after get from storage or camera (https://pub.dev/packages/image_cropper)
  add this to android manifest :
  <activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

- permission_handler => to handle permission such as storage, camera (https://pub.dev/packages/permission_handler)
From above link, you should add this to the podfile if you are running on iOS:
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      flutter_additional_ios_build_settings(target)

      # You can enable the permissions needed here. For example to enable camera
      # permission, just remove the `#` character in front so it looks like this:
      #
      # ## dart: PermissionGroup.camera
      # 'PERMISSION_CAMERA=1'
      #
      #  Preprocessor definitions can be found in: https://github.com/Baseflow/flutter-permission-handler/blob/master/permission_handler/ios/Classes/PermissionHandlerEnums.h
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.calendar
        # 'PERMISSION_EVENTS=1',

        ## dart: PermissionGroup.reminders
        # 'PERMISSION_REMINDERS=1',

        ## dart: PermissionGroup.contacts
        # 'PERMISSION_CONTACTS=1',

        ## dart: PermissionGroup.camera
        'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        # 'PERMISSION_MICROPHONE=1',

        ## dart: PermissionGroup.speech
        # 'PERMISSION_SPEECH_RECOGNIZER=1',

        ## dart: PermissionGroup.photos
        'PERMISSION_PHOTOS=1',

        ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
        # 'PERMISSION_LOCATION=1',

        ## dart: PermissionGroup.notification
        # 'PERMISSION_NOTIFICATIONS=1',

        ## dart: PermissionGroup.mediaLibrary
        # 'PERMISSION_MEDIA_LIBRARY=1',

        ## dart: PermissionGroup.sensors
        # 'PERMISSION_SENSORS=1',

        ## dart: PermissionGroup.bluetooth
        # 'PERMISSION_BLUETOOTH=1',

        ## dart: PermissionGroup.appTrackingTransparency
        # 'PERMISSION_APP_TRACKING_TRANSPARENCY=1',

        ## dart: PermissionGroup.criticalAlerts
        # 'PERMISSION_CRITICAL_ALERTS=1'
      ]

    end
  end
end

we add some logic function so if the user press back or done with this pages, cache images will be deleted and not makes the storage full

Don't forget to add all images and sound used in this pages at the pubspec.yaml

*** IMPORTANT NOTES FOR IOS ***
Image Picker will crash if you pick image for a second times, this error only exist on iOS Simulator 14 globaly around the world but not error on the real device
If you want to use iOS Simulator, you need to downgrade and using iOS Simulator 13
Follow this step to downgrade :
1. Xcode > Preferences
2. Select the "Components" tab.
3. Download and select Simulator 13 after the download is finish
4. Press "Check and Install Now".
5. After that, use Simulator 13 instead of simulator 14
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ijshopflutter/config/constants.dart';

class EditProfilePicturePage extends StatefulWidget {
  @override
  _EditProfilePicturePageState createState() => _EditProfilePicturePageState();
}

class _EditProfilePicturePageState extends State<EditProfilePicturePage> {
  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  // initialize global function
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();

  File? _image;
  final _picker = ImagePicker();

  File? _selectedFile;
  bool _inProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_selectedFile != null && _selectedFile!.existsSync()) {
      _selectedFile!.deleteSync();
    }
    _selectedFile = null;
    super.dispose();
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void _askPermissionCamera() {
    requestPermission(Permission.camera).then(_onStatusRequestedCamera);
  }

  void _askPermissionStorage() {
    requestPermission(Permission.storage).then(_onStatusRequested);
  }

  void _askPermissionPhotos() {
    requestPermission(Permission.photos).then(_onStatusRequested);
  }

  void _onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      _getImage(ImageSource.gallery);
    }
  }

  void _onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      _getImage(ImageSource.camera);
    }
  }

  // void uploadImage(File _selectedFile) {
  //   try {
  //     final data = {

  //     };
  //     final response = apiService.uploadImage(data, apiToken);
  //     print(response);

  //   } catch (e) {
  //     print(e);
  //     print('Erreur lors de l\'enregistrement du file  l\'image  ;');
  //   }
  // }

  void _getImage(ImageSource source) async {
    try {
      this.setState(() {
        _inProcess = true;
      });

      final pickedFile = await _picker.pickImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path); // chemin de l'image
        }
      });
      print(pickedFile?.path);
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkk");

      if (_image != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: _image!.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          cropStyle: CropStyle.circle,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              toolbarColor: Colors.white,
              toolbarTitle:
                  AppLocalizations.of(context)!.translate('edit_images')!,
              statusBarColor: PRIMARY_COLOR,
              activeControlsWidgetColor: CHARCOAL,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              toolbarWidgetColor: CHARCOAL,
              backgroundColor: Colors.white,
            ),
            IOSUiSettings(
              title: AppLocalizations.of(context)!.translate('edit_images')!,
            )
          ],
        );

        this.setState(() {
          if (cropped != null) {
            if (_selectedFile != null && _selectedFile!.existsSync()) {
              _selectedFile!.deleteSync();
            }
            _selectedFile = File(cropped.path);
          }

          // supprimer l'image de la caméra
          if (source == ImageSource.camera && _image!.existsSync()) {
            _image!.deleteSync();
          }

          _image = null;
          _inProcess = false;
        });
      } else {
        this.setState(() {
          _inProcess = false;
        });
      }
    } catch (e) {
      print(e);
      print("llllllllllllllllllllllllll");
      print('Erreur : $e');
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('edit_profile_picture')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  _getImageWidget(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: BLACK_GREY,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!
                                .translate('camera')!),
                          ],
                        ),
                        onTap: () {
                          _askPermissionCamera();
                        },
                      ),
                      Container(
                        width: 20,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.photo,
                              color: BLACK_GREY,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!
                                .translate('gallery')!),
                          ],
                        ),
                        onTap: () {
                          if (Platform.isIOS) {
                            _askPermissionPhotos();
                          } else {
                            _askPermissionStorage();
                          }
                        },
                      ),
                    ],
                  ),
                  _buttonSave()
                ],
              ),
            ),
            (_inProcess)
                ? Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center()
          ],
        ));
  }

  Widget _getImageWidget() {
    if (_selectedFile != null) {
      return ClipOval(
        child: Image.file(
          _selectedFile!,
          width: 250,
          height: 250,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return ClipOval(
        child: Image.asset(
          'assets/images/placeholder.jpg',
          width: 250,
          height: 250,
          fit: BoxFit.fill,
        ),
      );
    }
  }

  Widget _buttonSave() {
    if (_selectedFile != null) {
      //cette ligne Si un fichier d'image est sélectionné (non null)
      return Container(
        //Crée un conteneur pour le bouton avec une marge supérieure de 50 pixels
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ElevatedButton(
            // Crée un bouton élevé (bouton matériel standard)
            style: ButtonStyle(
              // Définir le style du bouton
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => PRIMARY_COLOR,
              ),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
            ),
            onPressed: () {
              // Lorsque le bouton est pressé
              if (_selectedFile != null && _selectedFile!.existsSync()) {
                // Si le fichier sélectionné existe
                _globalFunction.startLoading(
                    // Appelle une fonction pour démarrer le chargement
                    context,
                    AppLocalizations.of(context)!
                        .translate('upload_profile_picture_success')!,
                    1);
              } else {
                // Si le fichier sélectionné n'existe pas
                Fluttertoast.showToast(
                    // Affiche un message toast indiquant que le fichier n'a pas été trouvé
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    msg: AppLocalizations.of(context)!
                        .translate('file_not_found')!,
                    fontSize: 13,
                    toastLength: Toast.LENGTH_LONG);
              }
            },
            child: Padding(
              // Ajoute un padding (marge intérieure) autour du texte du bouton
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Text(
                // Le texte affiché sur le bouton
                AppLocalizations.of(context)!.translate('save')!,
                style: TextStyle(
                    // Style du texte
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
      );
    } else {
      // Si aucun fichier d'image n'est sélectionné (null)
      return Container();
    }
  }
}
