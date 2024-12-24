import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/styles_manager.dart';

class GridItemDesign extends StatelessWidget {
  final GridItem item;
  const GridItemDesign(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 20;
    if (width.isNegative) return Container();
    return SizedBox(
      width: width > 200 ? 200: (item.route.contains('sub') ? width*2:width) ,
      child: Padding(
        padding: PaddingManager.p4,
        child: ClipRRect(
          borderRadius: StyleManager.border,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: StyleManager.border,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.75)),
              child: InkWell(
                onTap: () => item.route.contains("youtube") ? launchUrl( Uri.parse(item.route)): Navigator.of(context).pushNamed(item.route),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8)), // Image border
                        child: Center(
                          child: item.image.contains("lottie") ? Lottie.asset(
                            item.image,
                            height: 100,
                            fit: BoxFit.fill,
                          ) :  Image.asset(item.image, height: 100,
                            fit: BoxFit.fill,),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          item.title,
                          strutStyle: const StrutStyle(
                            forceStrutHeight: true,
                            height: 1.5,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem {
  String route;
  String title;
  String image;

  GridItem({required this.route, required this.title, required this.image});
}
