import 'dart:io';

import 'package:final_projects/data/models/tournament.dart';
import 'package:final_projects/presentation/resources/routes_manger.dart';
import 'package:final_projects/presentation/resources/styles_manager.dart';
import 'package:final_projects/presentation/resources/theme/theme_manager.dart';
import 'package:final_projects/presentation/shared/widget/error_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/status.dart';
import '../../../../bloc/tournament_bloc/tournament_bloc.dart';
import '../../../../data/repositories/lanucher_extentions.dart';
import '../../../resources/asstes_manager.dart';
import '../../../shared/custom_scafffold/sliding_scaffold.dart';
import '../../../shared/custom_scafffold/top_widget.dart';
import '../../../shared/toast_helper.dart';
import '../../../shared/widget/dividers.dart';
import '../../../shared/widget/form_field.dart';
import '../../../shared/widget/loading_text.dart';
import '../../../shared/widget/numeric_field.dart';

class TournamentsDetails extends StatefulWidget {
  const TournamentsDetails(this.tournament, {super.key});
  final Tournament tournament;

  @override
  State<TournamentsDetails> createState() => _TournamentsDetailsState();
}

class _TournamentsDetailsState extends State<TournamentsDetails> {
  late final Map<String, TextEditingController> controllers = {
    "name": TextEditingController(
        text: widget.tournament.isRegistered?['team_name']),
    "teamMembersCount": TextEditingController(
        text: (widget.tournament.isRegistered?['team_num'] ?? 1).toString()),
    "supervisorName": TextEditingController(
        text: widget.tournament.isRegistered?['team_manager']),
    "country": TextEditingController(
        text: widget.tournament.isRegistered?['team_country']),
    "city": TextEditingController(
        text: widget.tournament.isRegistered?['team_city']),
    "academyAgeGroup": TextEditingController(
        text: (widget.tournament.isRegistered?['team_range'] ?? 14).toString()),
  };

  File? teamImage;
  final ImagePicker _picker = ImagePicker();

  late String selectedType = widget.tournament.types[0];
  late bool playedChampionship =
      widget.tournament.isRegistered?['play_before'] == 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SlidingScaffold(
        title: widget.tournament.name,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: FloatingActionButton(
            tooltip: widget.tournament.address,
            onPressed: () => launchMapsUrl(null, null),
            child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Lottie.asset(LottieManager.location))),
        child: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TopWidget(bottom: 20, child: topWidget(context)),
            ),
          ),
        ),
      ),
    );
  }

  Widget topWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Base64Image(widget.tournament.img, fit: BoxFit.fill),
              ),
            ),
          ),
          detailsSection(context),
          Dividers.h5,
          // AddressBox(tournament.address, tournament.lat, tournament.lan),
          // Dividers.h5,
          Dividers.horizontalLine,
          Dividers.h5,
          Text(
            "بيانات التسجيل",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Dividers.h5,
          getInfoWidget(),
          Dividers.h5,
          Center(
            child: BlocBuilder<TournamentBloc, TournamentState>(
              builder: (context, state) {
                print("here");
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: finalWidget(context, state.registrationStatus),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Academy Name and User Name
        customFormField(
            "name",
            widget.tournament.type == TournamentType.single
                ? "اسم الاعب"
                : "اسم الأكاديمية"),
        Dividers.h10,
        Visibility(
          visible: widget.tournament.type == TournamentType.team,
          child: customNumericField("teamMembersCount", "عدد اعضاء الفريق"),
        ),
        Dividers.h10,
        customFormField("supervisorName", "اسم المشرف الأكاديمي"),
        Dividers.h10,
        Row(
          children: [
            Expanded(child: customFormField("country", "الدولة")),
            Dividers.w5,
            Expanded(child: customFormField("city", "المدينة")),
          ],
        ),
        Dividers.h10,
        customFormField(
            "academyAgeGroup",
            widget.tournament.type == TournamentType.single
                ? "عمر الاعب"
                : " " "الفئة العمرية للأكاديمية ",
            keyboardType: TextInputType.number),

        Dividers.h10,
        // Championship Participation
        Directionality(
          textDirection: TextDirection.rtl,
          child: SwitchListTile(
            title: const Text("هل شاركت في بطولة من قبل؟"),
            value: playedChampionship,
            onChanged: (value) {
              setState(() {
                playedChampionship = value;
              });
            },
          ),
        ),
        Dividers.h10,
        const Center(
            child: Text("نوع الاشتراك",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold))),
        StatefulBuilder(builder: (context, ss) {
          return Row(
            children: widget.tournament.types
                .map((e) => Expanded(
                      child: FilterChip(
                        label: Text(
                          e,
                          style: const TextStyle(fontSize: 16),
                        ),
                        selected: e == selectedType,
                        onSelected: (value) {
                          ss(() {
                            selectedType = e;
                          });
                        },
                      ),
                    ))
                .toList(),
          );
        }),
        Dividers.h10,

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: Icon(
                  teamImage == null ? Icons.image_not_supported : Icons.image,
                  color: ColorManager.darkGrey,
                  size: 25,
                ),
                onPressed: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      teamImage = File(pickedFile.path);
                    });
                  } else {
                    showToast("No image selected");
                  }
                },
                label: const Text(
                  "اختيار شعار او صوره للفريق",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget customFormField(String controllerKey, String title,
          {TextInputType keyboardType = TextInputType.text, int? maxLines}) =>
      DefaultFormField(
        controller: controllers[controllerKey]!,
        title: title,
        maxLines: maxLines,
        keyboardType: keyboardType,
      );

  Widget customNumericField(
    String controllerKey,
    String title,
  ) =>
      Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
              width: 100,
              child: Text(title,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Dividers.w5,
          Expanded(
            child: NumericField(
              controllers[controllerKey]!,
            ),
          ),
        ],
      );

  Widget finalWidget(BuildContext context, BlocStatus status) {
    switch (status) {
      case BlocStatus.gettingData:
        return const LoadingText();
      default:
        return SizedBox(
          width: 150,
          height: 40,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: () {
                if (teamImage != null ||
                    widget.tournament.isRegistered?['team_photo'] != null) {
                  context.read<TournamentBloc>().add(RegisterTournamentEvent(
                      isInsertFlag:
                          widget.tournament.isRegistered?.isEmpty ?? false,
                      subId: widget.tournament.isRegistered?['id_champ_sub']
                          .toString(),
                      tournamentId: widget.tournament.id,
                      name: controllers['name']!.text,
                      memberCount: controllers['teamMembersCount']!.text,
                      supervisorName: controllers['supervisorName']!.text,
                      city: controllers['city']!.text,
                      country: controllers['country']!.text,
                      age: controllers['academyAgeGroup']!.text,
                      teamImage: convertImageToBase64(teamImage) ??
                          widget.tournament.isRegistered?['team_photo'],
                      playedChampionship: playedChampionship,
                      type: selectedType));
                }
              },
              icon: const Icon(
                Icons.send,
                size: 20,
              ),
              label: const Text("التسجيل"),
            ),
          ),
        );
    }
  }

  Widget detailsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "تفاصيل البطوله",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            widget.tournament.isAlamein
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.video);
                    },
                    child: Text(
                      "اضغط هنا لمشاهده فيديو بالتفاصيل",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ))
                : Text(
                    widget.tournament.description ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.tournament.date,
                  widget.tournament.category == TournamentCategory.local
                      ? "مسابقه محليه"
                      : "مسابقه عالميه",
                  widget.tournament.type == TournamentType.team
                      ? "التسجيل كفريق"
                      : "التسجيل فردي",
                ]
                    .map((e) => Card(
                          child: Padding(
                            padding:
                                PaddingManager.p4.copyWith(right: 8, left: 8),
                            child: Text(
                              e,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ))
                    .toList()),
            Dividers.h5,
          ],
        ),
      ),
    );
  }
}
