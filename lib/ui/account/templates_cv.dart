import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/services/network/api_service.dart';

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

class CVTemplatesScreen extends StatelessWidget {
  final List<CVTemplate> templates = [
    CVTemplate(
      name: 'Classique',
      description: 'Un modèle de CV classique et professionnel.',
      imageUrl: 'assets/images/templatescv/image.png',
    ),
    CVTemplate(
      name: 'Créatif',
      description: 'Un modèle de CV créatif et moderne.',
      imageUrl: 'assets/images/templatescv/image2.png',
    ),

    // Ajoutez d'autres modèles de CV ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modèles de CV'),
      ),
      body: ListView.builder(
        itemCount: templates.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Naviguer vers l'écran de détails du modèle de CV
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CVTemplateDetailScreen(template: templates[index]),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(templates[index].imageUrl),
                title: Text(templates[index].name),
                subtitle: Text(templates[index].description),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CVTemplate {
  final String name;
  final String description;
  final String imageUrl;

  CVTemplate(
      {required this.name, required this.description, required this.imageUrl});
}

class CVTemplateDetailScreen extends StatelessWidget {
  final CVTemplate template;

  CVTemplateDetailScreen({required this.template});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            template.imageUrl,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            template.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Action à effectuer lorsque l'utilisateur choisit ce modèle de CV
              print('Modèle ${template.name} sélectionné.');
            },
            child: Text('Choisir ce modèle'),
          ),
        ],
      ),
    );
  }
}
