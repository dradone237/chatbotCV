import 'package:ijshopflutter/services/common/helper.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@Collection()
class User {
  late String id = Uuid().v4();
  Id get isarId => fastHash(id);

  String? code;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  Asset? picture;

  @Enumerated(EnumType.name)
  UserType? type;
  Settings? setting;
  List<Contact>? contacts;
  List<Device>? devices;
  List<PersonalDocument>? personalDocuments;
  String? invitedBy;
  DateTime? birthdate;
  @Enumerated(EnumType.name)
  Sexe? sexe;
  //@Backlink(to: 'user')
  //final papers = IsarLinks<Paper>();
  bool? isSync = false;
  bool? isDelete = false;
  int? version = 1;
  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();

  User({
    this.code,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.picture,
    this.type,
    this.setting,
    this.contacts,
    this.devices,
    this.personalDocuments,
    this.invitedBy,
    this.sexe,
    this.birthdate,
    this.isSync,
    this.isDelete,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      code: json['code'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      picture: json['picture'] != null ? Asset.fromJson(json['picture']) : null,
      type: enumFromString<UserType>(json['type'] ?? '', UserType.values),
      setting:
          json['setting'] != null ? Settings.fromJson(json['setting']) : null,
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e))
          .toList(),
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e))
          .toList(),
      personalDocuments: (json['personalDocuments'] as List<dynamic>?)
          ?.map((e) => PersonalDocument.fromJson(e))
          .toList(),
      invitedBy: json['invitedBy'],
      sexe: enumFromString<Sexe>(json['sexe'] ?? '', Sexe.values),
      birthdate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      isSync: json['isSync'] ?? false,
      isDelete: json['isDeleted'] ?? false,
      version: json['version'] is num ? json['version'] : 1,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'isarId': isarId,
        'code': code,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'picture': picture?.toJson(),
        'type': enumToString(type),
        'setting': setting?.toJson(),
        'contacts': contacts?.map((e) => e.toJson()).toList(),
        'devices': devices?.map((e) => e.toJson()).toList(),
        'personalDocuments': personalDocuments?.map((e) => e.toJson()).toList(),
        'invitedBy': invitedBy,
        'sexe': enumToString(sexe),
        'birthdate': birthdate?.toIso8601String(),
        'isSync': isSync,
        'isDelete': isDelete,
        'version': version,
        'createdAt': createdAt?.toUtc().toIso8601String(),
        'updatedAt': updatedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> toJson2() => {
        // '_id': id,
        // 'isarId': isarId,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        // 'picture': picture?.toJson(),
        'type': enumToString(type),

        // 'teacher': teacher?.toJson(),
        'contacts': contacts?.map((e) => e.toJson2()).toList(),
        'devices': [],
        'invitedBy': invitedBy,
        'sexe': enumToString(sexe),
        'birthdate': birthdate?.toIso8601String(),
        'setting': setting?.toJson(),
        // 'isSync': isSync,
        // 'isDelete': isDelete,
        // 'version': version,
        // 'createdAt': createdAt?.toIso8601String(),
        // 'updatedAt': updatedAt?.toIso8601String(),
      };
}

@embedded
class PhoneNumber {
  String? id;
  String? number;
  @Enumerated(EnumType.name)
  MobileOperator? provider;
  bool? isMomo;
  bool? isVerified;

  PhoneNumber({
    // this.id,
    this.number,
    this.provider,
    this.isMomo,
    this.isVerified,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      // id: json['_id'],
      number: json['number'],
      provider: enumFromString<MobileOperator>(
        json['provider'] ?? '',
        MobileOperator.values,
      ),
      isMomo: json['isMomo'] ?? false,
      isVerified: json['isVerified'] ?? false,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id ?? Uuid().v4(),
        'number': number,
        'provider': enumToString(provider),
        'isMomo': isMomo,
        'isVerified': isVerified,
      };
}

@embedded
class Asset {
  String? id;
  String? filename;
  int? number;
  int? size;
  String? baseUrl;
  String? mime;
  @Enumerated(EnumType.name)
  ContentType? contentType;

  Asset({
    // this.id,
    this.filename,
    this.number,
    this.size,
    this.baseUrl,
    this.mime,
    this.contentType,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      // id: json['_id'] != null ? json['_id'] : '',
      filename: json['filename'] ?? '',
      number: json['number'] ?? 0,
      size: json['size'] ?? 0,
      baseUrl:
          json['baseUrl'] != null ? json['baseUrl'] ?? json['baseUrl'] : '',
      mime: json['mime'] ?? '',
      contentType: json['contentType'] != null
          ? getContentTypeFromMimeType(json['mime'])
          : ContentType.PICTURE,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id ?? Uuid().v4(),
        'filename': filename,
        'number': number,
        'size': size,
        'baseUrl': baseUrl,
        'mime': mime,
        'contentType': enumToString(contentType),
      };
}

@embedded
class Settings {
  String? id;
  String? language;
  List<String>? loisirs;
  List<String>? learnLanguages;
  List<String>? orderInfos;
  bool? settingNotification;
  bool? paperNotification;
  bool? logementNotification;
  bool? infoNotification;
  bool? changeNotification;
  DateTime? createdAt = DateTime.now();

  Settings({
    // this.id,
    this.language,
    this.loisirs,
    this.learnLanguages,
    this.orderInfos,
    this.settingNotification,
    this.paperNotification,
    this.logementNotification,
    this.infoNotification,
    this.changeNotification,
    this.createdAt,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      // id: json['_id'] != null ? json['_id'] : '',
      language: json['language'] ?? "FR",
      loisirs: json['loisirs']?.cast<String>() ?? [],
      learnLanguages: json['learnLanguages']?.cast<String>() ?? [],
      orderInfos: json['orderInfos']?.cast<String>() ?? [],
      settingNotification: json['settingNotification'] ?? true,
      paperNotification: json['paperNotification'] ?? true,
      logementNotification: json['logementNotification'] ?? true,
      infoNotification: json['infoNotification'] != null
          ? json['infoNotification'] ?? json['infoNotification']
          : true,
      changeNotification: json['changeNotification'] ?? true,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        // '_id': id ?? Uuid().v4(),
        'language': language ?? 'FR',
        'loisirs': loisirs,
        'learnLanguages': learnLanguages,
        'orderInfos': orderInfos,
        'settingNotification': settingNotification ?? true,
        'paperNotification': paperNotification ?? true,
        'logementNotification': logementNotification ?? true,
        'infoNotification': infoNotification ?? true,
        'changeNotification': changeNotification ?? true,
        'createdAt': createdAt?.toUtc().toIso8601String(),
      };
}

@embedded
class Position {
  String? id;
  double? latitude;
  double? longitude;
  String? address;

  Position({
    // this.id,
    this.latitude,
    this.longitude,
    this.address,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      // id: json['_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id ?? Uuid().v4(),
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };

  Map<String, Object?> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };
}

ContentType getContentTypeFromMimeType(String mimeType) {
  switch (mimeType) {
    case 'image/jpeg':
    case 'image/png':
    case 'image/jpg':
    case 'image/gif':
      return ContentType.PICTURE;
    case 'application/pdf':
      // case 'application/octet-stream':
      return ContentType.PDF;
    case 'application/msword':
    case 'application/docs':
    case 'application/xdocs':
    case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
      return ContentType.WORD;
    case 'text/html':
      return ContentType.HTML;
    case 'video/mp4':
    case 'video/mpeg':
    case 'video/quicktime':
    case 'video/x-msvideo':
      return ContentType.VIDEO;
    default:
      return ContentType.AUTRE;
  }
}

@embedded
class Contact {
  String? id;
  List<Asset>? assets;
  List<PhoneNumber>? phone;
  String? firstName;
  String? lastName;
  String? middleName;
  DateTime? birthdate;
  String? cniNumber;
  String? userID;
  List<Address>? addresses;
  @Enumerated(EnumType.name)
  Sexe? sexe;

  Contact({
    // this.id,
    this.assets,
    this.phone,
    this.firstName,
    this.lastName,
    this.middleName,
    this.birthdate,
    this.cniNumber,
    this.userID,
    this.addresses,
    this.sexe,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      // id: json['_id'] ?? '',
      assets: (json['assets'] as List<dynamic>?)
              ?.map((e) => Asset.fromJson(e))
              .toList() ??
          [],
      phone: json['phoneNumbers'] != null
          ? (json['phoneNumbers'] as List<dynamic>?)
              ?.map((e) => PhoneNumber.fromJson(e))
              .toList()
          : [],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      middleName: json['middleName'] ?? '',
      birthdate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      cniNumber: json['cniNumber'] ?? '',
      userID: json['userID'] ?? '',
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => Address.fromJson(e))
              .toList() ??
          [],
      sexe: enumFromString<Sexe>(json['sexe'] ?? '', Sexe.values),
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        'assets': assets?.map((e) => e.toJson()).toList(),
        'phone': phone?.map((e) => e.toJson()).toList(),
        '_id': id ?? Uuid().v4(),
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'birthdate': birthdate?.toIso8601String(),
        'cniNumber': cniNumber,
        'userID': userID,
        'addresses': addresses?.map((e) => e.toJson()).toList(),
        'sexe': enumToString(sexe),
      };
  Map<String, dynamic> toJson2() => {
        // 'assets': assets?.map((e) => e.toJson()).toList(),
        'phone': phone?.map((e) => e.toJson()).toList(),
        // '_id': id ?? Uuid().v4(),
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'birthdate': birthdate?.toIso8601String(),
        'cniNumber': cniNumber,
        'userID': userID,
        'addresses': addresses?.map((e) => e.toJson()).toList(),
        'sexe': enumToString(sexe),
      };
}

@embedded
class Address {
  String? id;
  String? name;
  String? zipCode;
  String? town;
  String? city;

  Address({
    // this.id,
    this.name,
    this.zipCode,
    this.town,
    this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      // id: json['_id'] ?? '',
      name: json['name'] ?? '',
      zipCode: json['zipCode'] ?? '',
      town: json['town'] ?? '',
      city: json['city'] ?? '',
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        // '_id': id ?? Uuid().v4(),
        'name': name,
        'zipCode': zipCode,
        'town': town,
        'city': city,
      };
}

@embedded
class Device {
  String? id;
  String? name;
  String? model;
  String? os;
  String? token;
  DateTime? lastDate;
  bool? isEnable;

  Device({
    // this.id,
    this.name,
    this.model,
    this.os,
    this.token,
    this.lastDate,
    this.isEnable,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      // id: json['_id'] ?? '',
      name: json['name'] ?? '',
      model: json['model'] ?? '',
      os: json['os'] ?? '',
      token: json['token'] ?? '',
      lastDate:
          json['lastDate'] != null ? DateTime.parse(json['lastDate']) : null,
      isEnable: json['isEnable'] ?? false,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id ?? Uuid().v4(),
        'name': name,
        'model': model,
        'os': os,
        'token': token,
        'lastDate': lastDate?.toIso8601String(),
        'isEnable': isEnable,
      };
}

@embedded
class PersonalDocument {
  String? id;
  @Enumerated(EnumType.name)
  PersonalDocType? type;
  List<Asset>? assets;

  PersonalDocument({
    this.id,
    this.type,
    this.assets,
    List<PersonalDocument>? personalDocuments,
  });

  factory PersonalDocument.fromJson(Map<String, dynamic> json) {
    return PersonalDocument(
      // id: json["_id"],
      type: enumFromString<PersonalDocType>(
          json['type'] ?? '', PersonalDocType.values),
      assets: (json['assets'] as List<dynamic>?)
              ?.map((e) => Asset.fromJson(e))
              .toList() ??
          [],
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id ?? Uuid().v4(),
        'type': enumToString(type),
        'assets': assets?.map((e) => e.toJson()).toList(),
      };
}

@embedded
class PaymentMethod {
  String? id;
  @Enumerated(EnumType.name)
  PaymentType? type;
  PhoneNumber? phoneNumber;

  PaymentMethod({
    // this.id,
    this.type,
    this.phoneNumber,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      // id: json["_id"],
      type: enumFromString<PaymentType>(json['type'] ?? '', PaymentType.values),
      phoneNumber: PhoneNumber.fromJson(json['phoneNumber'] ?? {}),
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        '_id': id ?? Uuid().v4(),
        'type': enumToString(type),
        'phoneNumber': phoneNumber?.toJson(),
      };
}

@embedded
class Comment {
  String? id = Uuid().v4();
  String? picture;
  String? comment;
  int? rate;
  String? name;
  List<String>? likes;
  String? parentId;
  String? user;
  DateTime? createAt;
  DateTime? updateAt;

  Comment({
    // this.id,
    this.picture,
    this.comment,
    this.rate,
    this.name,
    this.likes,
    this.parentId,
    this.user,
    this.createAt,
    this.updateAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      // id: json['_id'],
      picture: json['picture'],
      comment: json['comment'],
      rate: json['rate'] != null ? (json['rate'] as num?)?.toInt() : 0,
      name: json['name'],
      likes: (json['likes'] as List<dynamic>?)?.cast<String>() ?? [],
      parentId: json['parentId'],
      user: json['user'] is String ? json['user'] : "",
      createAt:
          json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    )..id = json['_id'] ?? Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id ?? Uuid().v4(),
      'picture': picture,
      'comment': comment,
      'rate': rate,
      'name': name,
      'likes': likes,
      'parentId': parentId,
      'user': user,
      'createAt': createAt?.toUtc().toIso8601String(),
      'updateAt': updateAt?.toUtc().toIso8601String(),
    };
  }
}

enum MobileOperator { ORANGE, MTN, CAMTEL, YOOMEE, AUTRE }

enum PaymentType {
  MTN_MOBILE_MONEY,
  ORANGE_MONEY,
  EXPRESS_UNION,
  PAYPAL,
  BANK_TRANSFER,
  CASH,
  AUTRE
}

enum PersonalDocType {
  IDENTITY_CARD,
  PASSPORT,
  DRIVER_LICENSE,
  SCHOOL_CERTIFICATE,
  HEALTH_RECORD,
  AUTRE
}

enum Sexe {
  MAN,
  WOMAN,
}

enum UserType { STUDENT, TEACHER, VISITER, ADMIN, AUTRE }

enum ContentType { PICTURE, PDF, WORD, HTML, VIDEO, AUTRE }

enum Status { NEW, PENDING, APPROVED, REFUSED, AUTRE }
