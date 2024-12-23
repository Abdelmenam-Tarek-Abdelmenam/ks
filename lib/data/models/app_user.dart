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
  String? nationalId;
  String? birthDate;
  String? city;
  ParentData parentData;

  double? weight;
  double? height;
  bool? playedBefore;
  String? experience;
  PlayType? playType;

  final String youtubeLink;
  final String phoneLink;
  final String emailLink;


  @override
  String toString() {
    return "User $name with email $email";
  }

  AppUser({
    required this.id,
    required this.youtubeLink,
    required this.phoneLink,
    required this.emailLink,
    this.photoUrl,
    this.phoneNumber,
    this.nationalId,
    this.birthDate,
    this.height,
    this.weight,
    required this.parentData ,
    this.city,
    this.playedBefore,
    this.playType,
    this.experience,
    this.verified = false,
    required super.name,
    required super.email,
  });

  // Factory method for an empty instance
  factory AppUser.empty() {
    return AppUser(
        name: '',
        id: '',
        email: '',
        youtubeLink: '',
        verified: false,
        parentData: ParentData.empty(), phoneLink: '', emailLink: '');
  }

  // Convert to JSON
  Map<String, dynamic> get toJson {
    Map<String,dynamic> data =  {
      'id_user': id,
      'NID_user': nationalId??'',
      'photo_user': photoUrl,
      'birth_user': birthDate,
      'grade_user': height,
      'city_user': city,
      'height_user': height,
      'weight_user': weight,
      'leg_user': ((playType ?? PlayType.rightFoot).index + 1) ,
      'play_before': (playedBefore??false)?1 : 0,
      'email_user': email,
      'name_user': name,
      'phone_user': phoneNumber.toString(),
      'sub_type': verified?1 : 0,
      'youtube_link': youtubeLink,
      'phone_link': youtubeLink,
      'email_link': youtubeLink,
    };

    data.addAll(parentData.toJson);

    return data;
  }

  // Create from JSON
  factory AppUser.fromJson(Map<String, dynamic> json, {String? email}) {

    return AppUser(
      youtubeLink: json['youtube_link'],
      phoneLink: json['phone_link']??'01201838240',
      emailLink: json['email_link']??'moneam@ebahy@gmail.com',
      id: (json['id']??json['id_user']).toString(),
      name: json['name_user'],
      nationalId: json['NID_user'],
      phoneNumber: json['phone_user'] ?? '',
      verified: json['sub_type'] != 0,
      email: email ?? json['email_user'],
      photoUrl: json['photo_user'],
      birthDate: json['birth_user'],
      experience: json['grade_user'].toString(),
      city: json['city_user'],
      height: json['height_user']?.toDouble(),
      weight: json['weight_user']?.toDouble(),
      playType: PlayType.values[(json['leg_user']??1)-1],
      playedBefore: json['play_before'] == 1,
      parentData: ParentData.fromJson(json),
    );
  }

  void updateFromJson(Map<String, dynamic> json) {
    name= json['name_user'];
    nationalId= json['NID_user']??name;
    phoneNumber= json['phone_user'] ?? phoneNumber;
    email=  json['email_user'] ?? email;
    photoUrl= json['photo_user'] ?? photoUrl;
    birthDate= json['birth_user'] ?? birthDate;
    experience= json['grade_user']??experience;
    city= json['city_user']?? city ;
    height= json['height_user']?? height;
    weight= json['weight_user'] ?? weight;
    playType= PlayType.values[json['leg_user']-1];
    playedBefore= json['play_before'] == 1;
    parentData.name = json['name_parent']?? parentData.name;
    parentData.id = json['NID_parent']?? parentData.id;
    parentData.job = json['job_parent']?? parentData.id;
    parentData.phone = json['phone_parent']?? parentData.phone;
    parentData.address = json['addr_parent']?? parentData.address;

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
  Map<String, String> get toJson {
    return {
      'name_parent': name,
      'NID_parent': id,
      'job_parent': job,
      'addr_parent': address,
      'phone_parent': phone,
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
      name: json['name_parent'] ?? '',
      id: json['NID_parent'] ?? '',
      job: json['job_parent'] ?? '',
      phone: json['phone_parent'] ?? '',
      address: json['addr_parent'] ?? '',
    );
  }
}

enum PlayType { rightFoot, leftFoot }

// Extension to add a custom Arabic `toString` method
extension PlayTypeExtension on PlayType {
  String toStringArabic() {
    switch (this) {
      case PlayType.rightFoot:
        return 'قدم يمنى';
      case PlayType.leftFoot:
        return 'قدم يسرى';
    }
  }

  Icon toIcon() {
    switch (this) {
      case PlayType.rightFoot:
        return const Icon(Icons.directions_run);
      case PlayType.leftFoot:
        return const Icon(Icons.directions_walk);
    }
  }
}
