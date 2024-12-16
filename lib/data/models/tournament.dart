class Tournament {
  final String id;
  final String img;
  final String name;
  final String date;
  final String? description;
  final String address;
  final TournamentCategory category;
  final TournamentType type;
  final bool isActive;
  final List<String> types = ['اعتيادي' , 'مخفض'];

  bool? isRegistered;

  Tournament(
      {required this.img,
      required this.name,
      this.isActive = true,
      required this.id,
      required this.date,
      required this.category,
      required this.address,
      required this.type,
      this.description});

  factory Tournament.fromJson(Map<String, dynamic> json) {
    print(json['id_champ']);
    return Tournament(
      id: json["id_champ"].toString(),
      img: json["photo_champ"],
      name: json["name_champ"],
      date: json["start_date"],
      isActive: json["type_reg"] == 1,
      address: json["addr_champ"],
      category: TournamentCategory.values[json["type_champ"] - 1],
      type: TournamentType.values[json["type_part"] - 1],
      description: " سعر الاشتراك ${json["price_champ"]}",
    );
  }

  Map<String, dynamic> get toJson => {
        "id": id,
        "img": img,
        "name": name,
        "date": date,
        "isActive": isActive,
        "address": address,
        "type": type.index, // Team , single
        "category": category.index, // Global - Local
        "description": description,
      };

  bool get isAlamein => (name.contains('العلمين'));
}

enum TournamentCategory { local, global }

enum TournamentType { single, team, both }
