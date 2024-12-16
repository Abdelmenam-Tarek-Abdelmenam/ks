import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_projects/presentation/shared/widget/dividers.dart';
import 'package:final_projects/presentation/shared/widget/form_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../data/repositories/lanucher_extentions.dart';
import '../resources/asstes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import 'customs_icons.dart';
import 'widget/error_image.dart';

class FacilitiesList extends StatelessWidget {
  const FacilitiesList(this.amenities, {super.key});
  final List<String> amenities;

  @override
  Widget build(BuildContext context) {
    return BackGround(
        child: Column(
      children: [
        Text(
          StringManger.facilities,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 2,
          children: amenities
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIcon(
                          "$iconsPath$e.svg",
                          width: 40,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Dividers.h10,
                        Text(e,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14)),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    ));
  }
}

class AddressBox extends StatelessWidget {
  const AddressBox(this.address, this.lat, this.lon, {super.key});
  final String address;
  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    return BackGround(
        child: Row(
      children: [
        Expanded(
            child: Text(
          address,
          textAlign: TextAlign.start,
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
        )),
        InkWell(
          onTap: () => launchMapsUrl(lat, lon),
          child: CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
            child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Lottie.asset(LottieManager.location)),
          ),
        )
      ],
    ));
  }
}

class ImagesList extends StatelessWidget {
  const ImagesList(this.images, {super.key});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: PaddingManager.p10,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
        borderRadius: StyleManager.border,
      ),
      child: images.isEmpty
          ? Center(
              child: Text(
              StringManger.noPhotos,
              style: Theme.of(context).textTheme.labelSmall,
            ))
          : Column(
              children: [
                SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width - 100,
                  child: CarouselSlider(
                    // carouselController: CarouselController(),
                    options: CarouselOptions(
                      autoPlay: false,
                    ),
                    items: images
                        .map((e) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ErrorImage(
                                e,
                                fit: BoxFit.fitHeight,
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
    );
  }
}

class ReviewList extends StatefulWidget {
  const ReviewList(this.reviews, {super.key});
  final List<String> reviews;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final TextEditingController newReview = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: PaddingManager.p10,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
        borderRadius: StyleManager.border,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width - 100,
            child: CarouselSlider(
              // carouselController: CarouselController(),
              options:
                  CarouselOptions(autoPlay: false, enableInfiniteScroll: false),
              items: List.generate(
                  widget.reviews.length + 1,
                  (index) => index == widget.reviews.length
                      ? OutlinedButton.icon(
                          onPressed: () => showAddDialog(context),
                          icon: const Icon(Icons.add_box_outlined),
                          label: Hero(
                            tag: "H",
                            child: Text(
                              StringManger.addReview,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ))
                      : Container(
                          padding: PaddingManager.p10,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: StyleManager.border,
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1)),
                          child: Center(
                              child: SingleChildScrollView(
                                  child: Text(
                            widget.reviews[index],
                            style: Theme.of(context).textTheme.labelSmall,
                          ))),
                        )),
            ),
          )
        ],
      ),
    );
  }

  void showAddDialog(BuildContext context) {
    newReview.clear();
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Dialog(
              backgroundColor:
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SizedBox(
                height: 250,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Hero(
                              tag: "H",
                              child: Text(
                                StringManger.addReview,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          Dividers.h10,
                          Form(
                            key: formKey,
                            child: DefaultFormField(
                              controller: newReview,
                              title: StringManger.review,
                              maxLines: 3,
                              hideBorder: true,
                              validator: (val) => val!.isEmpty
                                  ? StringManger.emptyReview
                                  : null,
                              prefix: Icons.message_outlined,
                            ),
                          ),
                          Dividers.h5,
                          FilledButton.tonalIcon(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  widget.reviews.add(newReview.text);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: Text(StringManger.add))
                        ],
                      ),
                    )),
              ),
              //  contentPadding: const EdgeInsets.all(0.0),
            ),
          );
        });
  }
}

class BackGround extends StatelessWidget {
  const BackGround({required this.child, this.padding, super.key});
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? PaddingManager.p10,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.95),
        borderRadius: StyleManager.border,
      ),
      child: child,
    );
  }
}

