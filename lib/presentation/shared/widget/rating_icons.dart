import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'gradient_icon.dart';

class RatingIcons extends StatelessWidget {
  const RatingIcons(this.rate, {Key? key}) : super(key: key);
  final double rate;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      rating: rate,
      itemBuilder: (context, index) => const GradientIcon(
          Icons.star,
          30,
          LinearGradient(colors: [
            Colors.orangeAccent,
            Colors.amberAccent,
          ])),
      itemCount: 5,
      itemSize: 25.0,
    );
  }
}
