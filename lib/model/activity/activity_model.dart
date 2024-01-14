class ActivityModel {
  late int id;
  late String title;
  late String image;
  late int review;
  late String service;
  late String printFormat;
  late String selectedLanguage;
  late String slideCount;
 

  ActivityModel({required this.id, required this.title, required this.image, required this.review, required this.service, required this.printFormat, required String selectedLanguage});

  ActivityModel.fromJson(Map<String, dynamic> json, ) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    review = json['review'];
    service = json['service'];
    printFormat =json['nom_service'];
    selectedLanguage = json['selectedLanguage'];
     slideCount = json[' slideCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['review'] = this.review;
    data['service'] = this.service;
    data['printFormat'] = this.printFormat;
    data['selectedLanguage'] =this.selectedLanguage;
    data['slideCount'] = this. slideCount;
    return data;
  }
}