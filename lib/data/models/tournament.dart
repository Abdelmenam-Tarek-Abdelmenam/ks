import 'dart:math';

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

  static List<Tournament> get generateRandomTournaments {
    List<String> names = [
      "بطولة العلمين الدولية",
      "بطولة الأهرامات المفتوحة",
      "كأس النيل المحلي",
      "بطولة القاهرة الكبرى",
      "دوري البحر الأحمر",
      "بطولة الساحل الشمالي",
      "بطولة الإسكندرية للفرق",
      "بطولة الخليج الفردية",
      "كأس الصحراء العالمية",
      "بطولة الأقصر التراثية"
    ];

    List<String> dates = [
      "2024-12-01",
      "2024-11-22",
      "2024-10-15",
      "2025-01-10",
      "2025-02-20"
    ];

    List<String> descriptions = [
      "بطولة تجمع أفضل اللاعبين من جميع أنحاء العالم.",
      "تنافس محلي بين الفرق على الكأس.",
      "حدث رياضي مميز في معالم مصر التاريخية.",
      "تحدي قوي بين الأفراد في لعبة مثيرة.",
      "بطولة تهدف إلى تعزيز الرياضة في المناطق الساحلية."
    ];

    Random random = Random();

    return List.generate(8, (index) {
      return Tournament(
        id : "",
        address: "21 El-Gaish Road, Al Mansheya Square, Alexandria, Egypt",
        lat: 31.199226,
        lan :29.894378,
        isActive: index==0 ? true : random.nextInt(2)==0,
        img: [
          "https://www.sinai.news/wp-content/uploads/2024/08/%D8%A3%D9%87%D9%84%D9%8A-%D8%B3%D9%8A%D9%86%D8%A7%D8%A1-2.jpg",
          "https://cdn.elwatannews.com/watan/300x150/1645802041725008353.jpg",
          "https://i.ytimg.com/vi/HT8sEDqnLIY/mqdefault.jpg",
        ][random.nextInt(3)],
        name: names[index],
        date: dates[random.nextInt(TournamentCategory.values.length)],
        category: TournamentCategory
            .values[random.nextInt(TournamentCategory.values.length)],
        type:
            TournamentType.values[random.nextInt(TournamentType.values.length)],
        description: descriptions[random.nextInt(descriptions.length)],
      );
    });
  }
}

enum TournamentCategory { local, global }

enum TournamentType { team, single }
