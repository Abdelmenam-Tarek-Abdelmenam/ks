import 'package:final_projects/data/models/app_user.dart';
import 'package:final_projects/presentation/shared/widget/dividers.dart';
import 'package:final_projects/presentation/view/landing_view/widgets/useer_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../data/data_sources/pref_repository.dart';
import '../../resources/routes_manger.dart';
import '../../resources/string_manager.dart';
import '../../shared/custom_scafffold/animated_splash.dart';
import '../../shared/custom_scafffold/gradient_scaffold.dart';
import '../../shared/custom_scafffold/top_widget.dart';
import '../../shared/on_will_pop.dart';
import 'widgets/home_grid.dart';

class LandingView extends StatelessWidget {
  const LandingView(this.state, {super.key});
  final HomePageStates state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showMyDialog(context),
      child: state == HomePageStates.splash
          ? SplashView(
              title: StringManger.appName,
              action: action(context),
              child: homePageView(context),
            )
          : GradientScaffold(
              action: action(context),
              child: homePageView(context),
            ),
    );
  }

  Widget action(BuildContext context) => BlocBuilder<AuthBloc, AuthStates>(
        builder: (context, state) {
          return IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                PreferenceRepository.clearAll();
                AuthBloc.user = AppUser.empty();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.login, (route) => false);
              });
        },
      );

  Widget homePageView(BuildContext context) => Column(
        children: [
          const TopWidget(bottom: 15, child: UserInfo()),
          Dividers.h15,
          HomeGrid()
        ],
      );
}

enum HomePageStates { splash, landing }
