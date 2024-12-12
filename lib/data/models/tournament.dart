
class Tournament {
  final String id;
  final String img;
  final String name;
  final String date;
  final String? description;
  final String address;
  final double lat;
  final double lan;
  final TournamentCategory category;
  final TournamentType type;
  final bool isActive;

  Tournament(
      {required this.img,
      required this.name, this.isActive = true,
      required this.id,
      required this.date,
      required this.category,
      required this.address,
      required this.lat,
      required this.lan,
      required this.type,
      this.description});

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
      id: json["id"],
      img: json["img"],
      name: json["name"],
      date: json["date"],
      isActive: json["isActive"],
      address: json["address"],
      lan: json["lan"],
      lat: json["lat"],
      category: TournamentCategory.values[json["category"] ?? 0],
      type: TournamentType.values[json["type"] ?? 0],
      description: json["description"]);

  Map<String, dynamic> get toJson => {
        "id": id,
        "img": img,
        "name": name,
        "date": date,
        "isActive": isActive,
        "address": address,
        "lan": lan,
        "lat": lat,
        "type": type.index, // Team , single
        "category": category.index, // Global - Local
        "description": description,
      };


  bool get isAlamein=> (name ==  "بطولة العلمين الدولية") ;

}



enum TournamentCategory { local, global }

enum TournamentType { team, single }
