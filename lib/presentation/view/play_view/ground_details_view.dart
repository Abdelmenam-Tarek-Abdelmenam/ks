import 'package:flutter/material.dart';


import '../../../data/models/matches.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../shared/details_widget.dart';
import '../../shared/widget/dividers.dart';

class GroundDetailsView extends StatelessWidget {
  const GroundDetailsView(this.ground, {Key? key}) : super(key: key);
  final Ground ground;

  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
      title: ground.name,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        child: const Icon(
          Icons.book_online,
        ),
        onPressed: () {},
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: PaddingManager.p15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              priceText(context),
              Dividers.h10,
              hoursText(context),
              Dividers.h10,
              FacilitiesList(ground.amenities),
              Dividers.h10,
              Text(
                StringManger.photos,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 18),
              ),
              Dividers.h5,
              ImagesList(ground.images),
              Dividers.h10,
              AddressBox(ground.address, ground.lat, ground.lon),
              Dividers.h10,
              Text(
                StringManger.reviews,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 18),
              ),
              Dividers.h5,
              ReviewList(ground.reviews),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceText(BuildContext context) => BackGround(
          child: Row(
            textDirection: TextDirection.rtl,

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "السعر",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
          Text(
            "${ground.price} جنيه للساعه ",
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
        ],
      ));

  Widget hoursText(BuildContext context) => BackGround(

          child: Row(
            textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "الساعات المتاحه",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
          Text(
            ground.activeHours,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
        ],
      ));
}

