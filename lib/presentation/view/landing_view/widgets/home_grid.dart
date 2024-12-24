import 'package:final_projects/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:flutter/material.dart';

import '../../../resources/asstes_manager.dart';
import '../../../resources/routes_manger.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import 'grid_item.dart';

class HomeGrid extends StatelessWidget {
  HomeGrid({super.key});

  final List<GridItem> items = [
    GridItem(
        title: StringManger.file,
        image: LottieManager.player,
        route: Routes.user),
    GridItem(
        title: StringManger.match,
        image: AssetsManager.ta,
        route: Routes.match),
    GridItem(
        title: StringManger.tournaments,
        image: LottieManager.tournaments,
        route: Routes.tournaments),

    GridItem(
        title: StringManger.leaderBoard,
        image: LottieManager.youtube,
        route: AuthBloc.user.youtubeLink),
    GridItem(
        title: 'الاشتراكات',
        image: LottieManager.sub,
        route: Routes.sub),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.p10,
      child: Center(
        child: Wrap(children: items.map((e) => GridItemDesign(e)).toList()),
      ),
    );
  }
}
