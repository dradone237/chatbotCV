import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/infos_user/langue.dart';
import 'package:ijshopflutter/ui/chat_user/activity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modèles de CV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CVTemplatesScreen(),
    );
  }
}

class CVTemplatesScreen extends StatefulWidget {
  @override
  _CVTemplatesScreenState createState() => _CVTemplatesScreenState();
}

class _CVTemplatesScreenState extends State<CVTemplatesScreen> {
  ApiService apiService = ApiService();
  CancelToken apiToken = CancelToken();
  final List<dynamic> imagePaths = [
    {'image': 'assets/images/model1/m1.png', 'id': 'template1.handlebars'}
    // 'assets/images/model1/m1.png',
    // 'assets/images/model1/m2.png',
    // 'assets/images/model1/m3.png',
    // 'assets/images/model1/m4.png',
    // 'assets/images/model1/m5.png',
  ];

//   ID1 = '42C06069-39A0-4FAE-B1A1-87DBCD7ADFEF'
//  ID2 = '7B7D5BA5-5AED-4935-8EC3-CEC642C4581E'

  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void saveuserinfostemplate(String templateId) {
    try {
      final data = {
        'templateId': templateId,
      };
      final response = apiService.saveuserinfostemplate(data, apiToken);
      print(response);

      // si l'utilisateur enregistre tous les informations alors il est diriger vers la page suivante
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => ChatPage()));
    } catch (e) {
      print(e);
      print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Modèles de CV')),
        automaticallyImplyLeading: false, // Retire la flèche de navigation
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: imagePaths.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return CVTemplateCard(imagePath: imagePaths[index]['image']);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex > 0)
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      currentIndex--;
                    });
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              Text('${currentIndex + 1}/${imagePaths.length}'),
              if (currentIndex < imagePaths.length - 1)
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      currentIndex++;
                    });
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              print('Modèle ${imagePaths[currentIndex]} sélectionné.');
              saveuserinfostemplate(imagePaths[currentIndex]['id']);
              print('ggggggggggggggggggggggggggggggggggggggggg');
              versChatPage(context);
            },
            child: Text('Sélectionner ce modèle'),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                versLanguePage(context);
              },
              child: Text('Retour'),
            ),
          ),
        ],
      ),
    );
  }
}

class CVTemplateCard extends StatelessWidget {
  final String imagePath;

  const CVTemplateCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

void versLanguePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LanguePage(),
    ),
  );
}

void versChatPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatPage(),
    ),
  );
}
