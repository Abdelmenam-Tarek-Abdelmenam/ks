import 'package:final_projects/presentation/resources/routes_manger.dart';
import 'package:final_projects/presentation/shared/widget/dividers.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/tournament.dart';

import '../../../resources/styles_manager.dart';
import '../../../shared/widget/error_image.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard(this.item, {Key? key}) : super(key: key);
  final Tournament item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: PaddingManager.p15.copyWith(top: 0),
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
        elevation: 0,
        child: InkWell(
          onTap: item.isActive ?(){
           Navigator.of(context).pushNamed(Routes.tournamentsDetails , arguments: item);
          } : null,
          child: Column(
            children: [
              Dividers.h5,
              Padding(
                padding: PaddingManager.p8.copyWith(bottom: 0,top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      item.type == TournamentType.team
                          ? Icons.groups
                          : Icons.person, // Team or Single icon
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    FittedBox(
                      child: Text(
                        item.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      item.category == TournamentCategory.local
                          ? Icons.location_city // Local tournament icon
                          : Icons.public, // Global tournament icon
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Dividers.h5,
              Expanded(
                child:Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipRRect(
                        borderRadius:
                        const BorderRadius.vertical(bottom: Radius.circular(10)),
                        child: ErrorImage(
                          item.img,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                    Card(child: Padding(
                      padding: PaddingManager.p8,
                      child: Text(item.date , style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
