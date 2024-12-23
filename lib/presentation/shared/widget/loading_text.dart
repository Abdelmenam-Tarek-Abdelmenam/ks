import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingText extends StatelessWidget {
  const LoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "جاري التحميل ",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 20 , color:  Theme.of(context).colorScheme.onPrimary),
            ),
            SpinKitThreeBounce(
              color: Theme.of(context).colorScheme.onPrimary,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
