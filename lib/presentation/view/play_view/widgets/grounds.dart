import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../../../../data/models/matches.dart';
import '../../../../data/models/show_data.dart';
import '../../../resources/asstes_manager.dart';
import '../../../resources/routes_manger.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../shared/widget/dividers.dart';
import '../../../shared/widget/rating_icons.dart';

class GroundsWidget extends StatelessWidget {
   GroundsWidget({super.key});
   final ShowData<Ground> grounds =ShowData<Ground>(dummyGrounds);

  @override
  Widget build(BuildContext context) {
    return grounds.isEmpty
        ? noGrounds(context)
        : Wrap(
            children: grounds.data.map((e) => GroundDesign(e)).toList(),
          );
  }

  Widget noGrounds(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 250,
              child: Lottie.asset(LottieManager.ground,
                  height: 250, fit: BoxFit.fitHeight)),
          Text(
            StringManger.noGrounds,
            style: Theme.of(context).textTheme.displayMedium,
          )
        ],
      );
}

class GroundDesign extends StatelessWidget {
  const GroundDesign(this.item, {Key? key}) : super(key: key);
  final Ground item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: PaddingManager.p15.copyWith(bottom: 5),
      width: double.infinity,
      padding: PaddingManager.p10,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.65),
        image: DecorationImage(
          image: NetworkImage(item.img),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
        borderRadius: StyleManager.border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 25,
                        ),
                        Dividers.w10,
                        Expanded(
                          child: Text(
                            item.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        )
                      ],
                    ),
                    Dividers.h5,
                    Row(
                      children: [
                        const Icon(Icons.sports, size: 25),
                        Dividers.w10,
                        Text(
                          item.activeHours,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: PaddingManager.p4,
                  child: FittedBox(child: Text(item.price.toString())),
                ),
              )
            ],
          ),
          RatingIcons(item.rating),
          Center(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)),
              onPressed: () => Navigator.pushNamed(
                  context, Routes.groundDetails,
                  arguments: item),
              label: Text(StringManger.showMore),
              icon: const Icon(
                Icons.send,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
List<Ground> dummyGrounds = [
  Ground(
    name: "Green Field",
    address: "123 Sports Lane, Cairo",
    price: 500.0,
    img: "https://st.depositphotos.com/1162190/2462/i/450/depositphotos_24622155-stock-photo-soccer-ball-stadium-light.jpg",
    rating: 4.8,
    activeHours: "8 AM - 10 PM",
    amenities: ["Ball", "Drinks", "Changing Room", "Cafeteria"],
    reviews: ["Great place!", "Loved the atmosphere."],
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s"
    ],
    lat: 30.0444,
    lon: 31.2357,
  ),
  Ground(
    name: "Skyline Arena",
    address: "456 Victory Road, Alexandria",
    price: 750.0,
    img: "https://st.depositphotos.com/1162190/2462/i/450/depositphotos_24622155-stock-photo-soccer-ball-stadium-light.jpg",
    rating: 4.6,
    activeHours: "10 AM - 12 AM",
    amenities: ["Ball", "Cafeteria"],
    reviews: ["Spacious and clean!", "Friendly staff."],
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s"
    ],
    lat: 31.2001,
    lon: 29.9187,
  ),
  Ground(
    name: "Sunset Sports Complex",
    address: "789 Horizon Blvd, Giza",
    price: 300.0,
    img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
    rating: 4.3,
    activeHours: "7 AM - 9 PM",
    amenities: ["Drinks", "Changing Room"],
    reviews: ["Affordable and well-maintained.", "Perfect for group games."],
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s"
    ],
    lat: 29.9765,
    lon: 31.1313,
  ),
  Ground(
    name: "Riverside Grounds",
    address: "321 River Drive, Aswan",
    price: 600.0,
    img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
    rating: 4.7,
    activeHours: "9 AM - 11 PM",
    amenities: ["Ball", "Drinks"],
    reviews: ["Beautiful location!", "Would visit again."],
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s"
    ],
    lat: 24.0889,
    lon: 32.8998,
  ),
  Ground(
    name: "Downtown Sports Hub",
    address: "987 City Square, Luxor",
    price: 400.0,
    img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
    rating: 4.4,
    activeHours: "8 AM - 10 PM",
    amenities: ["Changing Room", "Cafeteria"],
    reviews: ["Convenient location.", "Good amenities for the price."],
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR13U9A5k-AGV4VguRNps8xxIrKvRywn-vTlA&s"
    ],
    lat: 25.6872,
    lon: 32.6396,
  ),
];