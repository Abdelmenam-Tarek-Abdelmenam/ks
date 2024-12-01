import 'package:flutter/material.dart';

import 'dividers.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dividers.h15,
          Icon(
            Icons.error_outline_sharp,
            size: 100,
            color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
          ),
          Dividers.h15,
          FittedBox(
            child: Text(
              "Sorry we have a problem now try again later",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
