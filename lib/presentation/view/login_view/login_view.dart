// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:final_projects/presentation/view/login_view/widgets/login_page_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../resources/routes_manger.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../shared/custom_scafffold/animated_splash.dart';
import '../../shared/on_will_pop.dart';
import '../../shared/toast_helper.dart';
import '../../shared/widget/dividers.dart';
import '../../shared/widget/form_field.dart';
import '../../shared/widget/loading_text.dart';
import 'dart:math' as math;

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController1 = TextEditingController();
  final TextEditingController passController2 = TextEditingController();
  bool showPass1 = true;
  bool showPass2 = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showMyDialog(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SplashView(
            showDivider: false,
            menuIcon: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: PaddingManager.p15.copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LoginPageIcon(),
                      emailBox(context),
                      Dividers.h10,
                      // const LoginIcons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailBox(BuildContext context) => ClipRRect(
        borderRadius: StyleManager.border,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: PaddingManager.p10,
            decoration: BoxDecoration(
                borderRadius: StyleManager.border,
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.75)),
            child: BlocConsumer<AuthBloc, AuthStates>(
              listener: (context, state) {
                if (state.status == AuthStatus.successLogIn || state.status == AuthStatus.successSignUp) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.home, (route) => false);
                }
              },
              builder: (context, state) {
                return AnimatedSize(
                  duration: const Duration(milliseconds: 750),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AuthModes.values
                            .map((e) => modeItem(e, state.mode, context))
                            .toList(),
                      ),
                      DefaultFormField(
                        controller: emailController,
                        title: StringManger.emailAddress,
                        fillHint: AutofillHints.email,
                      ),
                      passwordsWidgets(state.mode),
                      Dividers.h10,
                      SizedBox(
                        height: 40,
                        child: AnimatedCrossFade(
                          crossFadeState:
                              state.status == AuthStatus.submittingEmail
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                          firstChild: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => callBack(context, state.mode),
                                child: Text(state.mode.getName)),
                          ),
                          secondChild: const LoadingText(),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

  Widget modeItem(AuthModes e, AuthModes mode, BuildContext context) =>
      Expanded(
        child: InkWell(
          onTap: () => context.read<AuthBloc>().add(ChangeAuthModeEvent(e)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  child: Text(
                e.getName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8)),
              )),
              Visibility(
                visible: e == mode,
                child: Transform.rotate(
                    angle: -math.pi / 2,
                    child: Icon(Icons.play_arrow_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.8))),
              ),
            ],
          ),
        ),
      );

  Widget passwordsWidgets(AuthModes mode) => Column(
    children: [
      Dividers.h15,
      StatefulBuilder(
        builder: (_, setState) => DefaultFormField(
          controller: passController1,
          title: StringManger.password,
          isPass: showPass1,
          suffix: IconButton(
            icon: Icon(showPass1 ? Icons.lock_reset : Icons.lock_open),
            onPressed: () {
              setState(() {
                showPass1 = !showPass1;
              });
            },
          ),
        ),
      ),
      mode == AuthModes.signUp
          ? Column(
              children: [
                Dividers.h15,
                StatefulBuilder(
                  builder: (_, setState) => DefaultFormField(
                    controller: passController2,
                    title: StringManger.password2,
                    isPass: showPass2,
                    suffix: IconButton(
                      icon: Icon(
                          showPass2 ? Icons.lock_reset : Icons.lock_open),
                      onPressed: () {
                        setState(() {
                          showPass2 = !showPass2;
                        });
                      },
                    ),
                  ),
                )
              ],
            )
          : Container(),
    ],
  );

  void callBack(BuildContext context, AuthModes mode) {

    switch (mode) {
      case AuthModes.login:
        context.read<AuthBloc>().add(
            LoginInUsingEmailEvent(emailController.text, passController1.text));
        break;
      case AuthModes.signUp:
        if (passController1.text == passController2.text) {
          context.read<AuthBloc>().add(SignUpInUsingEmailEvent(
              emailController.text, passController1.text));
        } else {
          showToast(StringManger.wrongPasswords);
        }
        break;
    }
  }
}
