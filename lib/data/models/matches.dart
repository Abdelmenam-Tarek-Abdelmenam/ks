const List<String> service = ['Changing Room' , 'Ball', 'Cafeteria'];

class Ground {
  String id;
  String name;
  String address;
  int price;
  String? img;
  String activeHours;
  List<String> amenities;
  List<String> images;
  String location ;

  Ground({
    required this.id,
    required this.name,
    required this.address,
    required this.price,
    required this.img,
    required this.activeHours,
    required this.amenities,
    required this.images,
    required this.location,
  });

  factory Ground.fromJson(Map<String, dynamic> json) => Ground(
        id: json['id_court'].toString(),
        name: json['name_court'],
        address: json['addr_court'],
        price: json['price_court'],
        img: json['photo1_court'],
        activeHours: json['activeHours']??'لا يوجد ساعات متاحه',
        images: [json['photo2_court']??'' , json['photo3_court']??'' ],
        amenities: [service[json['service_court']-1]],
        location: json['location_court'],
      );

  // Map<String, dynamic> get toJson => {
  //       "name": name,
  //       "address": address,
  //       "price": price,
  //       "img": img,
  //       "activeHours": activeHours,
  //       "amenities": amenities.join(","),
  //       "rating": rating,
  //       "images": images,
  //       "reviews": reviews,
  //       "lon": lon,
  //       "lat": lat,
  //     };
}
