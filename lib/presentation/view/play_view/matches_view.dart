import 'package:final_projects/presentation/view/play_view/widgets/store_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../bloc/matches_bloc/matches_bloc.dart';
import '../../../bloc/status.dart';
import '../../resources/string_manager.dart';
import '../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../shared/widget/loading_text.dart';
import 'widgets/grounds.dart';

class MatchesView extends StatelessWidget {
  MatchesView({Key? key}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
        title: StringManger.match,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar:
            bottomBar(context, context.watch<PlayBloc>().state.type),
        child: Expanded(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropHeader(),
            onRefresh: () {
              // PlayBloc bloc = context.read<PlayBloc>();
                  // bloc.add(const GetGroundsEvent());

            },
            child: ListView(
              children: [
                BlocBuilder<PlayBloc, PlayState>(
                  builder: (context, state) {

                    print(state.type);
                    if (state.type == MatchesViewType.grounds) {
                      switch (state.groundStatus) {
                        case BlocStatus.idle:
                          return GroundsWidget();
                        case BlocStatus.gettingData:
                          return const LoadingText();
                        case BlocStatus.getData:
                          endRefresh();
                          return GroundsWidget();
                        case BlocStatus.error:
                          endRefresh();
                          return GroundsWidget();
                          // return const ErrorView();
                      }
                    } else if (state.type == MatchesViewType.active) {
                      switch (state.matchesStatus) {
                        case BlocStatus.idle:
                          return StoreView();
                        case BlocStatus.gettingData:
                          return const LoadingText();
                        case BlocStatus.getData:
                          endRefresh();
                          return StoreView();
                        case BlocStatus.error:
                          endRefresh();
                          return StoreView();
                          // return const Center(child: ErrorView());
                      }
                    } else {
                      return const LoadingText();
                    }
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> bottomBar(BuildContext context, MatchesViewType type) =>
      MatchesViewType.values
          .map((i) => SizedBox(
                width: 100,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.65),
                      backgroundColor: i == type
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2)
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  icon: Icon(
                    i.toIcon(),
                    size: 20,
                  ),
                  label: FittedBox(
                    child: Text(
                      i.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w100, fontSize: 14),
                    ),
                  ),
                  onPressed: () {
                    context.read<PlayBloc>().add(ChangeViewTypeEvent(i));
                  },
                ),
              ))
          .toList();

  void communityCallback(BuildContext context) {}


  void endRefresh() {
    Future.delayed(const Duration(milliseconds: 20)).then((value) {
      if (_refreshController.isRefresh) _refreshController.refreshCompleted();
      if (_refreshController.isLoading) _refreshController.loadComplete();
    });
  }
}
