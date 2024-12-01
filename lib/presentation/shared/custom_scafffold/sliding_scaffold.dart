import 'package:final_projects/presentation/shared/custom_scafffold/widgets/gradient_container.dart';
import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';

const double panelHeight = 25;

class SlidingScaffold extends StatelessWidget {
  const SlidingScaffold(
      {required this.child,
      required this.title,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.action,
      this.tabs,
      this.showSliding = true,
      super.key});
  final Widget child;
  final bool showSliding;
  final Widget? floatingActionButton;
  final Widget? action;
  final List<Widget>? bottomNavigationBar;
  final List<Widget>? tabs;
  final String title;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      DefaultTabController(
        length: tabs?.length ?? 0,
        child: Scaffold(
          floatingActionButtonLocation: floatingActionButtonLocation ??
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar:
              bottomNavigationBar == null ? null : bottomBar(context),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: action == null ? null : [action!],
            title: Text(title),
            bottom: tabs == null
                ? null
                : TabBar(
                    labelPadding: PaddingManager.p10,
                    indicatorColor: Theme.of(context).colorScheme.onPrimary,
                    tabs: tabs!),
          ),
          body: lastChild(context),
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) => BottomAppBar(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.65),
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: bottomNavigationBar!,
          ),
        ),
      );

  Widget lastChild(BuildContext context) => Column(
        children: [whiteDivider(context), child],
      );

  Widget whiteDivider(BuildContext context) => Divider(
        thickness: 2,
        height: 1,
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      );
}
