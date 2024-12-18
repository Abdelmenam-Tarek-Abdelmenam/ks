import 'package:final_projects/presentation/view/play_view/widgets/store_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../bloc/matches_bloc/matches_bloc.dart';
import '../../../bloc/status.dart';
import '../../../data/models/matches.dart';
import '../../../data/models/product.dart';
import '../../resources/string_manager.dart';
import '../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../shared/widget/error_widget.dart';
import '../../shared/widget/loading_text.dart';
import 'widgets/grounds.dart';

class MatchesView extends StatelessWidget {
  MatchesView({super.key});
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
              PlayBloc bloc = context.read<PlayBloc>();
              if (bloc.state.type == MatchesViewType.grounds) {
                bloc.add(const GetGroundsEvent());
              }else if (bloc.state.type == MatchesViewType.store){
                bloc.add(const GetProductsEvent());
              }
            },
            child: ListView(
              children: [
                BlocBuilder<PlayBloc, PlayState>(
                  builder: (context, state) {
                    print(state.type);
                    if (state.type == MatchesViewType.grounds) {
                      switch (state.groundStatus) {
                        case BlocStatus.idle:
                          return GroundsWidget(grounds);
                        case BlocStatus.gettingData:
                          return const LoadingText();
                        case BlocStatus.getData:
                          endRefresh();
                          return GroundsWidget(grounds);
                        case BlocStatus.error:
                          endRefresh();
                          return const ErrorView();
                      }
                    } else if (state.type == MatchesViewType.store) {
                      print(state.productsStatus);
                      switch (state.productsStatus) {
                        case BlocStatus.idle:
                          return StoreView(products);
                        case BlocStatus.gettingData:
                          return const LoadingText();
                        case BlocStatus.getData:
                          endRefresh();
                          return StoreView(products);
                        case BlocStatus.error:
                          endRefresh();
                          return const Center(child: ErrorView());
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

  void endRefresh() {
    Future.delayed(const Duration(milliseconds: 20)).then((value) {
      if (_refreshController.isRefresh) _refreshController.refreshCompleted();
      if (_refreshController.isLoading) _refreshController.loadComplete();
    });
  }
}



final List<Ground> grounds = [
  Ground(
    id: '1',
    name: 'Central Park Ground',
    address: '123 Main St, New York, NY',
    price: 50.0,
    img: 'assets/images/ground1.jpg',
    activeHours: '08:00 AM - 10:00 PM',
    amenities: [service[0], service[2]], // 'Changing Room', 'Cafeteria'
    images: [
      'assets/images/ground1_1.jpg',
      'assets/images/ground1_2.jpg',
    ],
    location: '40.785091, -73.968285',
  ),
  Ground(
    id: '2',
    name: 'Sunrise Sports Field',
    address: '456 Elm St, Los Angeles, CA',
    price: 75.0,
    img: 'assets/images/ground2.jpg',
    activeHours: '06:00 AM - 11:00 PM',
    amenities: [service[1], service[2]], // 'Ball', 'Cafeteria'
    images: [
      'assets/images/ground2_1.jpg',
      'assets/images/ground2_2.jpg',
    ],
    location: '34.052235, -118.243683',
  ),
];

final List<Product> products = [
  Product(
    name: 'Wireless Headphones',
    provider: 'TechStore Inc.',
    picture: null,
    price: 120.50,
    id: 'P001',
  ),
  Product(
    name: 'Smart Watch',
    provider: 'Gadget World',
    picture: null, // No picture provided
    price: 80.00,
    id: 'P002',
  ),
  Product(
    name: 'Bluetooth Speaker',
    provider: 'SoundWave Ltd.',
    picture: null,
    price: 45.99,
    id: 'P003',
  ),
];