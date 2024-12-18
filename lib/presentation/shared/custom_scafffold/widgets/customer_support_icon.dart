import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../resources/asstes_manager.dart';
import '../../../resources/routes_manger.dart';
import '../../../resources/string_manager.dart';

class CustomerSupportIcon extends StatelessWidget {
  const CustomerSupportIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        tooltip: StringManger.about,
        backgroundColor:
            Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        elevation: 0,
        child: Lottie.asset(LottieManager.about, width: 80),
        onPressed: () =>
            Navigator.of(context).pushNamed(Routes.customerSupport));
  }
}
