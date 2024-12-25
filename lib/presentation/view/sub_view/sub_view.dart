import 'package:final_projects/bloc/sub_bloc/sub_bloc.dart';
import 'package:final_projects/presentation/view/sub_view/widgets/champ_view.dart';
import 'package:final_projects/presentation/view/sub_view/widgets/talents_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../bloc/status.dart';
import '../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../shared/widget/error_widget.dart';
import '../../shared/widget/loading_text.dart';

class SubView extends StatelessWidget {
  SubView({super.key});
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
        title: "الاشتراكات",
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar:
            bottomBar(context, context.watch<SubBloc>().state.type),
        child: Expanded(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropHeader(),
            onRefresh: () {
              SubBloc bloc = context.read<SubBloc>();
              bloc.add(const GeSubEvent());
            },
            child: ListView(
              children: [
                BlocBuilder<SubBloc, SubState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case BlocStatus.gettingData:
                        return const LoadingText();
                      case BlocStatus.error:
                        // endRefresh();
                        return const ErrorView();
                      default:
                        endRefresh();
                        if (state.type == SubViewType.talents) {
                          return TalentsView(state.data.talents);
                        } else {
                          return ChampView(state.data.champ);
                        }
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> bottomBar(BuildContext context, SubViewType type) => SubViewType
      .values
      .map((i) => SizedBox(
            width: 100,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.65),
                  backgroundColor: i == type
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
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
                context.read<SubBloc>().add(ChangeViewTypeEvent(i));
              },
            ),
          ))
      .toList();

  void endRefresh() {
    Future.delayed(const Duration(milliseconds: 20)).then((value) {
      if (_refreshController.isRefresh) _refreshController.refreshCompleted();
      if (_refreshController.isLoading) _refreshController.loadComplete();
    });
  }
}
