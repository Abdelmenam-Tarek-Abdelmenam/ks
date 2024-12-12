import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../bloc/status.dart';
import '../../../bloc/tournament_bloc/tournament_bloc.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../shared/custom_scafffold/top_widget.dart';
import '../../shared/widget/error_widget.dart';
import '../../shared/widget/loading_text.dart';
import 'widgets/active_tournaments.dart';
import 'widgets/tournaments_list.dart';

class TournamentsView extends StatelessWidget {
  TournamentsView({super.key});
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
        title: StringManger.tournaments,
        child: Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropHeader(),
            onRefresh: () => context.read<TournamentBloc>().add(
                const GetTournamentEvent()),
            controller: _refreshController,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<TournamentBloc, TournamentState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      TopWidget(
                          bottom: 10,
                          child: ActiveTournamentsList(state.active)),
                      Padding(
                        padding: PaddingManager.p15,
                        child: rightBuild(context, state),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }

  Widget rightBuild(BuildContext context, TournamentState state) {
    switch (state.status) {
      case BlocStatus.idle:
        return TournamentsList(state.other);
      case BlocStatus.gettingData:
        return const LoadingText();
      case BlocStatus.getData:
        endRefresh();
        return TournamentsList(state.other);
      case BlocStatus.error:
        endRefresh();
        return const ErrorView();
    }
  }

  void endRefresh() {
    Future.delayed(const Duration(milliseconds: 20)).then((value) {
      if (_refreshController.isRefresh) _refreshController.refreshCompleted();
      if (_refreshController.isLoading) _refreshController.loadComplete();
    });
  }
}
