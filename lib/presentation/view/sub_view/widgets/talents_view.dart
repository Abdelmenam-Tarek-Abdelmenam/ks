import 'package:flutter/material.dart';

import '../../../../domain_layer/repository_implementer/sub_repo.dart';
import '../../../resources/styles_manager.dart';

class TalentsView extends StatelessWidget {
  const TalentsView(this.talents,{super.key});
  final List<Subscription> talents;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: talents
            .map((e) => Padding(
          padding: PaddingManager.p10,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text(e.name),
              trailing: Text(e.endDate),
              leading: CircleAvatar(
                child: Text(e.sessionsNum)
              ),
              subtitle: Text(e.price),
            ),
          ),
        ))
            .toList());
  }
}
