
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/matches_bloc/matches_bloc.dart';
import '../../../../data/models/product.dart';
import '../../../../domain_layer/repository_implementer/play_repo.dart';
import '../../../resources/asstes_manager.dart';
import '../../../resources/routes_manger.dart';

import '../../../resources/styles_manager.dart';
import '../../../shared/widget/dividers.dart';
import '../../../shared/widget/error_image.dart';

class ProductDesign extends StatelessWidget {
  final Product item;
  const ProductDesign(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 30;
    return Container(
      margin: const EdgeInsets.all(5.0),
      width: width > 200 ? 200 : width,
      height: 230,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.65),
        borderRadius: StyleManager.border,
      ),
      child: InkWell(
        onTap: () {

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("تـاكيد الاشتراك"),
            content: Text("هل انت متاكد انك تريد الاشتراك"),
            actions: [
              TextButton(
                child: Text("نعم"),
                onPressed: () {
                  context.read<PlayBloc>().add(
                      RegisterProductsEvent(ProductRegister(
                          idSub: item.id)));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );

        },
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Column(
                children: [
                  Hero(
                    tag: item.id,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10)), // Image border
                      child: item.img == ""
                          ? Image.asset(
                        AssetsManager.noProductImage,
                              height: constraints.maxHeight * .58,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : ErrorImage(
                              item.img,
                              height: constraints.maxHeight * .58,
                              width: double.infinity,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FittedBox(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            strutStyle: const StrutStyle(
                              forceStrutHeight: true,
                              height: 1.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Dividers.h5,
                        Text(
                          item.provider,
                          maxLines: 1,
                          strutStyle: const StrutStyle(
                            forceStrutHeight: true,
                            height: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,

                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          "${item.price} ${"سعر الاشتراك"}",
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Positioned(
              //   right: 5,
              //   top: constraints.maxHeight * .58 - 35,
              //   child: const CircleAvatar(
              //     radius: 20,
              //     // backgroundColor: Theme.of(context).primaryColor,
              //     child: Icon(
              //       Icons.add_shopping_cart_sharp,
              //       size: 22,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
