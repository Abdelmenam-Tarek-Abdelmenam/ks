import 'dart:ui';

import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({required this.child, required this.bottom, Key? key})
      : super(key: key);
  final Widget child;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.65),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(60))),
      child: Padding(
        padding: PaddingManager.p8.copyWith(bottom: bottom),
        child: child,
      ),
    );
  }
}
