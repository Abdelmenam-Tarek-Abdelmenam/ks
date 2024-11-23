import 'package:flutter/material.dart';

import '../resources/string_manager.dart';

Future<bool> showMyDialog(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(StringManger.warning,
              style: Theme.of(context).textTheme.displayLarge),
          content: Text(
            StringManger.exitQ,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                StringManger.no,
                style: const TextStyle(color: Colors.greenAccent),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                StringManger.yes,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      )) ??
      false;
}
