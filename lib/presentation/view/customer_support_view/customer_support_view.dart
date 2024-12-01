import 'package:flutter/material.dart';

import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../shared/custom_scafffold/top_widget.dart';
import 'widgets/contact_icons.dart';
import 'widgets/info_widget.dart';

class CustomerSupportView extends StatelessWidget {
  const CustomerSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SlidingScaffold(
          title: StringManger.about,
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              // physics: const BouncingScrollPhysics(),
              child: ListView(
                children: [
                  const TopWidget(bottom: 30, child: InfoWidget()),
                  Padding(
                    padding: PaddingManager.p15,
                    child: ContactsIcons(),
                  ),
                  // const SizedBox(
                  //   height: 100,
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}
