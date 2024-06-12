import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/services/models/cvuserModel.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class CvHistoryPage extends StatefulWidget {
  @override
  _CvHistoryPageState createState() => _CvHistoryPageState();
}

class _CvHistoryPageState extends State<CvHistoryPage> {
  final _globalFunction = GlobalFunction();
  ApiService apiService = ApiService();
  CancelToken apiToken = CancelToken();
  List<CvuserModel> cvHistory = [];

  @override
  void initState() {
    super.initState();
    loadCvHistory();
  }

  Future<dynamic> loadCvHistory() async {
    try {
      List<CvuserModel> cvs = await apiService.getCvHistory(apiToken);
      setState(() {
        cvHistory = cvs;
      });
      print(cvs);
      print("verification nnnnnn");
    } catch (e) {
      print(e);
    }
  }

  Future<File> viewPdf(String id, String path) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      print(path);
      final file = await _globalFunction.getFileFromCacheSave(BASE_URL + path);
      print(file);
      print(file?.path);
      print("verificationpppppppp");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewer(
            path: file?.path,
          ),
        ),
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<void> sharePdf(String id, String path) async {
    try {
      final file = await _globalFunction.getFileFromCacheSave(BASE_URL + path);
      await Share.shareXFiles([XFile(file?.path ?? "")], text: "le nom du cv");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des CV'),
      ),
      body: ListView.builder(
        itemCount: cvHistory.length,
        itemBuilder: (context, index) {
          final cv = cvHistory[index];
          return ListTile(
            title: Text('CV ${cv.id}'),
            subtitle: Text('Créé le: ${cv.dateCreation}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () => viewPdf(cv.id, cv.path),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => sharePdf(cv.id, cv.path),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
