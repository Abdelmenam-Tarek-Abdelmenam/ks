
import 'app_user.dart';

class Ground {
  String name;
  String address;
  double price;
  String img;
  double rating;
  String activeHours;
  List<String> amenities;
  // Ball,Drinks,Changing Room,Cafeteria
  List<String> reviews;
  List<String> images;
  double lat;
  double lon;

  Ground({
    required this.name,
    required this.address,
    required this.price,
    required this.img,
    required this.rating,
    required this.activeHours,
    required this.amenities,
    required this.images,
    required this.reviews,
    required this.lat,
    required this.lon,
  });

  factory Ground.fromJson(Map<String, dynamic> json) => Ground(
        name: json['name'],
        address: json['address'],
        price: json['price'],
        img: json['img'],
        activeHours: json['activeHours'],
        images: List<String>.from(json['images'] ?? []),
        reviews: List<String>.from(json['reviews'] ?? []),
        amenities: json['amenities'].split(","),
        rating: json['rating'],
        lat: json['lat'],
        lon: json['lon'],
      );

  Map<String, dynamic> get toJson => {
        "name": name,
        "address": address,
        "price": price,
        "img": img,
        "activeHours": activeHours,
        "amenities": amenities.join(","),
        "rating": rating,
        "images": images,
        "reviews": reviews,
        "lon": lon,
        "lat": lat,
      };
}

