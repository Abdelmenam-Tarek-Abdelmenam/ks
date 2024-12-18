class Product {
  final String name;
  final String provider;
  final String? picture;
  int price;
  final String id;

  String get img => picture ?? 'https://m.gomhuriaonline.com/Upload/News/22-2-2024_15_17_23_GomhuriaOnline_161708607843.jpg';

  Product({
    required this.name,
    required this.provider,
    this.picture,
    required this.price,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name_sub"],
        provider: '${ json["num_session"]} مرات حضور',
        price: json["price_sub"],
        id: json["id_sub"].toString(),
      );

}

class OfferItem {
  final double oldPrice;
  final Product product;

  OfferItem({required this.product, required this.oldPrice});

  factory OfferItem.fromJson(Map<String, dynamic> json) =>
      OfferItem(product: Product.fromJson(json), oldPrice: json['oldPrice']);
}
