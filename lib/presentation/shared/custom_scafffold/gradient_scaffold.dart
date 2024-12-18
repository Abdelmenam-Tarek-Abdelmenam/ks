import 'package:final_projects/presentation/shared/custom_scafffold/widgets/customer_support_icon.dart';
import 'package:flutter/material.dart';


import '../../resources/asstes_manager.dart';
import '../../resources/string_manager.dart';
import 'widgets/gradient_container.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({required this.child, this.action,this.title,  this.floatingActionButton,
    this.floatingActionButtonLocation,super.key});
  final Widget child;
  final Widget? action;
  final String? title;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: floatingActionButtonLocation??FloatingActionButtonLocation.startFloat,
          floatingActionButton: floatingActionButton??const CustomerSupportIcon(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(title??StringManger.appName),
            actions: action == null
                ? null
                : [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: action!,
                    )
                  ],
          ),
          body: Stack(
            children: [
              whiteDivider(context),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Hero(
                    tag: "KMANLogo",
                    child: Image.asset(
                      AssetsManager.logo,
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget whiteDivider(BuildContext context) => Divider(
        thickness: 2,
        height: 0,
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      );
}
