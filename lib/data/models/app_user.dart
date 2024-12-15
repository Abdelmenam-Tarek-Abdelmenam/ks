import 'package:flutter/material.dart';

class DefaultUser {
  String name;
  String email;

  DefaultUser({required this.name, required this.email});

  factory DefaultUser.empty() => DefaultUser(name: "", email: "");

  bool get noUser => name.isEmpty || email.isEmpty;

  // inputs : { uname : ""  , email : ""  , password : "" ,

  Map<String, String> loginJson(String pass) {
    return {'uname': name, 'email': email, 'password': pass};
  }
}

class AppUser extends DefaultUser {
  final String id;
  String? photoUrl;
  bool verified;

  String? phoneNumber;
  int? nationalId;
  String? birthDate;
  String? academicYear;
  String? city;

  ParentData? parentData;

  int? weight;
  int? height;
  bool? playedBefore;
  String? experience;
  String? startPlaying;
  PlayType? playType;

  @override
  String toString() {
    return "User $name with email $email";
  }

  AppUser({
    required this.id,
    this.photoUrl,
    this.phoneNumber,
    this.nationalId,
    this.birthDate,
    this.height,
    this.weight,
    this.academicYear,
    this.parentData,
    this.city,
    this.playedBefore,
    this.playType,
    this.experience,
    this.startPlaying,
    this.verified = false,
    required super.name,
    required super.email,
  });

  // Factory method for an empty instance
  factory AppUser.empty() {
    return AppUser(
        id: '',
        name: '',
        email: '',
        verified: false,
        parentData: ParentData.empty());
  }

  // Convert to JSON
  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'email': email,
      'photoUrl': photoUrl,
      'name': name,
      'phone': phoneNumber,
      'nationalId': nationalId,
      'academicYear': academicYear,
      'parentData': parentData?.toJson ?? {},
      'height': height,
      'experience': height,
      'weight': weight,
      'city': city,
      'date': birthDate,
      'playedBefore': playedBefore,
      'startPlaying': playedBefore,
      'playType': (playType ?? PlayType.unknown).index,
      'verified': verified,
    };
  }

  // Create from JSON
  factory AppUser.fromJson(Map<String, dynamic> json, {String? email}) {
    return AppUser(
      id: json['id'].toString(),
      name: json['name'],
      phoneNumber: json['phone'] ?? '',
      verified: json['subtype'] != 0,
      email: email ?? json['email'],
      photoUrl: json['photoUrl'],
      parentData: ParentData.fromJson(json['parentData'] ?? {}),
      experience: json['experience'],
      nationalId: json['nationalId'],
      academicYear: json['academicYear'],
      city: json['city'],
      playedBefore: json['playedBefore'],
      startPlaying: json['startPlaying'],
      height: json['height'],
      birthDate: json['date'],
      weight: json['weight'],
      playType: PlayType.values[json['playType'] ?? 2],
    );
  }

  void updateFromJson(Map<String, dynamic> json) {
    name = json['name'] ?? name;
    phoneNumber = json['phone'] ?? phoneNumber;
    email = json['email'] ?? email  ;
    photoUrl = json['photoUrl'] ?? photoUrl;
    parentData = json['parentData']!=null ? ParentData.fromJson(json['parentData']) : parentData;
    experience = json['experience'] ?? experience;
    nationalId = json['nationalId']??nationalId;
    academicYear = json['academicYear']??academicYear;
    city = json['city']??city;
    playedBefore = json['playedBefore']??playedBefore;
    startPlaying = json['startPlaying']??startPlaying;
    height = json['height']??height;
    birthDate = json['date']??birthDate;
    weight = json['weight']??weight;
    playType = json['playType'] != null ? PlayType.values[json['playType'] ?? 2] :  playType;
  }

  bool get isEmpty => id == '';
}

class ParentData {
  String name;
  String id;
  String phone;
  String job;
  String address;

  ParentData({
    required this.name,
    required this.id,
    required this.job,
    required this.phone,
    required this.address,
  });

  // Convert to JSON
  Map<String, dynamic> get toJson {
    return {
      'name': name,
      'id': id,
      'job': job,
      'address': address,
      'phone': phone,
    };
  }

  // Factory method for an empty instance
  factory ParentData.empty() {
    return ParentData(
      name: '',
      id: '',
      job: '',
      phone: '',
      address: '',
    );
  }

  // Create from JSON
  factory ParentData.fromJson(Map<String, dynamic> json) {
    return ParentData(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      job: json['job'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

enum PlayType { rightFoot, leftFoot, unknown }

// Extension to add a custom Arabic `toString` method
extension PlayTypeExtension on PlayType {
  String toStringArabic() {
    switch (this) {
      case PlayType.rightFoot:
        return 'قدم يمنى';
      case PlayType.leftFoot:
        return 'قدم يسرى';
      case PlayType.unknown:
      default:
        return 'كلاهما';
    }
  }

  Icon toIcon() {
    switch (this) {
      case PlayType.rightFoot:
        return const Icon(Icons.directions_run);
      case PlayType.leftFoot:
        return const Icon(Icons.directions_walk);

      case PlayType.unknown:
      default:
        return const Icon(Icons.help_outline);
    }
  }
}
