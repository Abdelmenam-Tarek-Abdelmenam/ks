import 'package:final_projects/presentation/view/tournaments_view/widgets/tournament_card.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/show_data.dart';
import '../../../../data/models/tournament.dart';


class TournamentsList extends StatelessWidget {
  const TournamentsList(this.tournaments, {super.key});
  final ShowData<Tournament> tournaments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, i) => TournamentCard(tournaments.data[i]),
        itemCount: tournaments.data.length);
  }
}
