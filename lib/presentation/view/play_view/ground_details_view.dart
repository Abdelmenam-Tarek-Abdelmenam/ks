import 'package:final_projects/bloc/matches_bloc/matches_bloc.dart';
import 'package:final_projects/bloc/status.dart';
import 'package:final_projects/domain_layer/repository_implementer/play_repo.dart';
import 'package:final_projects/presentation/shared/custom_scafffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/matches.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../shared/details_widget.dart';
import '../../shared/widget/date_picker.dart';
import '../../shared/widget/dividers.dart';

class GroundDetailsView extends StatelessWidget {
  GroundDetailsView(this.ground, {super.key});
  final Ground ground;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: ground.name,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<PlayBloc, PlayState>(
        builder: (context, state) {
          return state.rGround == BlocStatus.gettingData ? const CircularProgressIndicator():FloatingActionButton(
            backgroundColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
            child: const Icon(
              Icons.book_online,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<PlayBloc>().add(RegisterGroundsEvent(
                    GroundRegister(
                        idCourt: ground.id,
                        dateRsvCourt: dateController.text,
                        startRsvCourt: startTimeController.text,
                        endRsvCourt: endTimeController.text)));
              }
            },
          );
        },
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: PaddingManager.p15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              priceText(context),
              Dividers.h10,
              hoursText(context),
              Dividers.h10,
              FacilitiesList(ground.amenities),
              Dividers.h10,
              Text(
                StringManger.photos,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 18),
              ),
              Dividers.h5,
              ImagesList(ground.images),
              Dividers.h10,
              AddressBox(ground.address, ground.location),
              Dividers.h10,
              Text(
                "معلومات الحجز",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 18),
              ),
              Dividers.h10,
              registrationWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget registrationWidget(BuildContext context) => Container(
        width: double.infinity,
        padding: PaddingManager.p10,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
          borderRadius: StyleManager.border,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomDateTimePicker(
                labelText: 'تاريخ الحجز',
                controller: dateController,
                isReverse: false,
                onValidate: (d) {
                  if (d == null || d.isEmpty) {
                    return 'يرجي ملئ التاريخ';
                  }
                  return null;
                },
              ),
              Dividers.h5,
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: CustomTimePicker(
                      labelText: 'وقت البدايه ',
                      controller: startTimeController,
                      onValidate: (d) {
                        if (d == null || d.isEmpty) {
                          return 'يرجي ملئ الوقت';
                        }
                        return null;
                      },
                    ),
                  ),
                  Dividers.w10,
                  Expanded(
                    child: CustomTimePicker(
                      labelText: 'وقت النهايه ',
                      controller: endTimeController,
                      onValidate: (d) {
                        if (d == null || d.isEmpty) {
                          return 'يرجي ملئ الوقت';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget priceText(BuildContext context) => BackGround(
          child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "السعر",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
          Text(
            "${ground.price} جنيه للساعه ",
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
        ],
      ));

  Widget hoursText(BuildContext context) => BackGround(
          child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "الساعات المتاحه",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
          Text(
            ground.activeHours,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 18),
          ),
        ],
      ));
}
