import 'package:final_projects/data/models/tournament.dart';
import 'package:flutter/material.dart';

import '../../../resources/routes_manger.dart';
import '../../../resources/styles_manager.dart';
import '../../../shared/widget/error_image.dart';

class ChampView extends StatelessWidget {
  const ChampView(this.champs,{super.key});
  final List<Tournament> champs ;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: champs
            .map(
              (e) => Padding(
            padding: PaddingManager.p10,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: Text(e.name),
                onTap: () {
                  print(e);
                  // return;
                  Navigator.of(context)
                      .pushNamed(Routes.tournamentsDetails, arguments: e);
                },
                trailing: Text(e.date),
                leading: ClipOval(
                  child: Base64Image(
                    e.img,
                    height: 60,
                    width: 60,
                  ),
                ),
                subtitle: Text(e.description ?? ""),
              ),
            ),
          ),
        )
            .toList());
  }
}
