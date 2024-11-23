import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../bloc/auth_bloc/auth_status_bloc.dart';

import '../../../resources/asstes_manager.dart';
import '../../../resources/styles_manager.dart';

class LoginPageIcon extends StatelessWidget {
  const LoginPageIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStates>(
        buildWhen: (prev, next) => prev.mode != next.mode,
        builder: (context, state) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: writeIcon(context, state.mode));
        });
  }

  Widget writeIcon(BuildContext context, AuthModes mode) {
    switch (mode) {
      case AuthModes.login:
        return Container(
          key: const Key("l"),
          height: 120,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
              shape: BoxShape.circle),
          margin: PaddingManager.p15.copyWith(top: 0),
          padding: PaddingManager.p15.copyWith(top: 10),
          child:
              Lottie.asset(LottieManager.login, width: 100, fit: BoxFit.cover),
        );
      case AuthModes.signUp:
        return Container(
          key: const Key("s"),
          height: 120,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
              shape: BoxShape.circle),
          margin: PaddingManager.p15.copyWith(top: 0),
          padding: PaddingManager.p15,
          child:
              Lottie.asset(LottieManager.signup, width: 130, fit: BoxFit.cover),
        );
    }
  }
}
