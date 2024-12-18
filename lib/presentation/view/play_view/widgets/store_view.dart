import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_projects/data/models/product.dart';
import 'package:final_projects/presentation/view/play_view/widgets/product_design.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../resources/asstes_manager.dart';
import '../../../resources/routes_manger.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';

import '../../../shared/custom_scafffold/top_widget.dart';

import '../../../shared/widget/dividers.dart';
import '../../../shared/widget/error_image.dart';

class StoreView extends StatelessWidget {
  StoreView(this.products ,{super.key});
 final List<Product> products ;
 final List<OfferItem> offers = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopWidget(bottom: 20, child: OffersList(offers)),
        Padding(
          padding: PaddingManager.p15,
          child: Center(
            child: Wrap(children: [
              ...products.map((e) => ProductDesign(e)),
            ]),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class OffersList extends StatelessWidget {
  const OffersList(this.offers, {super.key});
  final List<OfferItem> offers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: offers.isEmpty
          ? noOffers(context)
          : CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: offers.map((e) => offerCard(context, e)).toList(),
            ),
    );
  }

  Widget noOffers(BuildContext context) => Padding(
        padding: PaddingManager.p15.copyWith(top: 0),
        child: Card(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
          elevation: 0,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: -10,
                child: Transform.rotate(
                    angle: 2.9,
                    child: Icon(
                      Icons.apps,
                      size: 220,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    )),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      LottieManager.offers,
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              "لا يوجد عروض",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Text(
                            "تابعنا لتري كل جديد",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    Dividers.w10
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget offerCard(
    BuildContext context,
    OfferItem item,
  ) {
    return Padding(
      padding: PaddingManager.p2.copyWith(top: 0, bottom: 10),
      child: InkWell(
        // onTap: () => Navigator.of(context)
        //     .pushNamed(Routes.product, arguments: (item.product)),
        child: Card(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
          elevation: 0,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: -10,
                child: Transform.rotate(
                    angle: 2.9,
                    child: Icon(
                      Icons.apps,
                      size: 220,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 150,
                          child: ErrorImage(
                            item.product.img,
                          )),
                    ],
                  ),
                ),
              ),
              Transform.rotate(
                angle: -0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.oldPrice} ${StringManger.priceUnit}",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16),
                      ),
                      Text("${item.product.price} ${StringManger.priceUnit}",
                          style: Theme.of(context).textTheme.displaySmall)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: PaddingManager.p2.copyWith(left: 8),
                child: Text(
                  item.product.name,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
