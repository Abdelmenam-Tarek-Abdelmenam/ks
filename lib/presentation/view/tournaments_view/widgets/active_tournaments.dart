import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/models/tournament.dart';
import '../../../resources/asstes_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import 'tournament_card.dart';

class OldTournamentsList extends StatelessWidget {
  const OldTournamentsList(this.tournaments, {super.key});
  final List<Tournament> tournaments;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: tournaments.isEmpty
          ? noTournaments(context)
          : CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: tournaments.map((e) => TournamentCard(e)).toList(),
            ),
    );
  }

  Widget noTournaments(BuildContext context) => Padding(
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
                      size: 500,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    )),
              ),
              Center(
                child: Lottie.asset(
                  LottieManager.noTournaments,
                  height: 140,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  StringManger.noTournaments,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      );
}
