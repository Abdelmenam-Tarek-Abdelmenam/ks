import 'dart:io';
import 'dart:ui';

import 'package:final_projects/data/models/app_user.dart';
import 'package:final_projects/presentation/resources/theme/theme_manager.dart';
import 'package:final_projects/presentation/shared/toast_helper.dart';
import 'package:final_projects/presentation/shared/widget/numeric_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/auth_bloc/auth_status_bloc.dart';

import '../../../bloc/user_info_bloc/user_info_status_bloc.dart';
import '../../resources/styles_manager.dart';
import '../../shared/custom_scafffold/gradient_scaffold.dart';
import 'dart:math' as math;
import '../../shared/widget/dividers.dart';
import '../../shared/widget/error_image.dart';
import '../../shared/widget/form_field.dart';
import '../../shared/widget/loading_text.dart';
import '../../shared/widget/date_picker.dart';

class UserInfoView extends StatelessWidget {
  UserInfoView({super.key});

  // Centralized controller mapping for better organization
  final Map<String, TextEditingController> controllers = {
    "parentName": TextEditingController(text: AuthBloc.user.parentData.name),
    "parentPhone": TextEditingController(text: AuthBloc.user.parentData.phone),
    "parentId": TextEditingController(text: AuthBloc.user.parentData.id),
    "parentJob": TextEditingController(text: AuthBloc.user.parentData.job),
    "parentAddress":
        TextEditingController(text: AuthBloc.user.parentData.address),
    "name": TextEditingController(text: AuthBloc.user.name),
    "phone": TextEditingController(text: AuthBloc.user.phoneNumber),
    "id":
        TextEditingController(text: AuthBloc.user.nationalId?.toString() ?? ""),
    "date": TextEditingController(
        text: (AuthBloc.user.birthDate ?? '').isEmpty
            ? null
            : AuthBloc.user.birthDate),
    "city": TextEditingController(text: AuthBloc.user.city),
    "weight":
        TextEditingController(text: (AuthBloc.user.weight ?? 0).toString()),
    "height":
        TextEditingController(text: (AuthBloc.user.height ?? 0).toString()),
    "experience": TextEditingController(text: AuthBloc.user.experience),
  };

  PlayType? playType = AuthBloc.user.playType;
  bool playedBefore = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientScaffold(
                  title: "معلومات الاعب",
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: PaddingManager.p15,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(tag: "image", child: userImage(context)),
                              Dividers.h10,
                              signUpWidgets(context),
                              Dividers.h10,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }

  Widget signUpWidgets(BuildContext context) => ClipRRect(
        borderRadius: StyleManager.border,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: PaddingManager.p10,
            decoration: BoxDecoration(
                borderRadius: StyleManager.border,
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.75)),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 750),
              child: BlocBuilder<UserInfoBloc, InfoStates>(
                  builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: InfoModes.values
                          .map((e) => modeItem(e, state.mode, context))
                          .toList(),
                    ),
                    infoWidget(state.mode, context),
                    sendButton(context)
                  ],
                );
              }),
            ),
          ),
        ),
      );

  Widget infoWidget(InfoModes mode, BuildContext context) {
    switch (mode) {
      case InfoModes.personal:
        return personalInfo();
      case InfoModes.parents:
        return parentInfo();
      case InfoModes.sports:
        return sportsInfo(context);
    }
  }

  Widget sportsInfo(BuildContext context) => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const SizedBox(
                        width: 100,
                        child: Text("الوزن (kg)",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Dividers.w5,
                    Expanded(child: customNumericField("weight", '')),
                  ],
                ),
                Dividers.h15,
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const SizedBox(
                        width: 100,
                        child: Text("الطول (cm)",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Dividers.w5,
                    Expanded(child: customNumericField("height", "")),
                  ],
                ),
              ],
            ),
          ),
          Dividers.h10,
          StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: PlayType.values
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: FilterChip(
                              backgroundColor: Colors.transparent,
                              onSelected: (_) {
                                setState(() {
                                  playType = e;
                                });
                              },
                              label: Text(
                                e.toStringArabic(),
                                style: const TextStyle(fontSize: 14),
                              ),
                              selected: playType == e),
                        ),
                      ))
                  .toList(),
            );
          }),
          Dividers.h10,
          StatefulBuilder(
              builder: (context, setState) => Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: SwitchListTile(
                          title: const Text("هل سبق اللعب من قبل؟"),
                          value: playedBefore,
                          onChanged: (value) {
                            setState(() {
                              playedBefore = value;
                            });
                          },
                        ),
                      ),
                      Dividers.h10,
                      Visibility(
                        visible: playedBefore,
                        child: Column(
                          children: [
                            customFormField("experience", "الخبرة",
                                keyboardType: TextInputType.multiline,
                                maxLines: 2), // ,
                          ],
                        ),
                      )
                    ],
                  )),
          Dividers.h10,
        ],
      );

  Widget parentInfo() => Column(
        children: [
          customFormField("parentName", "اسم ولي الامر"),
          customFormField("parentPhone", "رقم هاتف ولي الامر",
              keyboardType: TextInputType.phone),
          customFormField("parentId", "الرقم القومي لولي الامر",
              keyboardType: TextInputType.number),
          customFormField("parentJob", "وظيفة ولي الامر"),
          customFormField("parentAddress", "عنوان ولي الامر"),
        ].expand((widget) => [widget, const SizedBox(height: 10)]).toList(),
      );

  Widget personalInfo() => Column(
        children: [
          customFormField("name", "الاسم"),
          customFormField("phone", "رقم الهاتف",
              keyboardType: TextInputType.phone),
          customFormField("id", "الرقم القومي",
              keyboardType: TextInputType.number),
          customDatePicker("date", "تاريخ الميلاد"),
          customFormField("city", "المدينة"),
        ].expand((widget) => [widget, const SizedBox(height: 10)]).toList(),
      );

  Widget customFormField(String controllerKey, String title,
          {TextInputType keyboardType = TextInputType.text, int? maxLines}) =>
      DefaultFormField(
        controller: controllers[controllerKey]!,
        title: title,
        maxLines: maxLines,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'لا يمكنك ترك الحقل فارغا';
          }
          return null;
        },
        keyboardType: keyboardType,
      );
  Widget customNumericField(
    String controllerKey,
    String title,
  ) =>
      NumericField(
        controllers[controllerKey]!,
        title: title,
      );

  Widget customDatePicker(String controllerKey, String labelText) =>
      CustomDateTimePicker(
        labelText: labelText,
        controller: controllers[controllerKey]!,
      );

  Widget modeItem(InfoModes e, InfoModes mode, BuildContext context) =>
      Expanded(
        child: InkWell(
          onTap: () => context.read<UserInfoBloc>().add(ChangeUserModeEvent(e)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  child: Text(
                e.getName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8)),
              )),
              Visibility(
                visible: e == mode,
                child: Transform.rotate(
                    angle: -math.pi / 2,
                    child: Icon(Icons.play_arrow_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.8))),
              ),
            ],
          ),
        ),
      );

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Widget userImage(BuildContext context) =>
      StatefulBuilder(builder: (context, setState) {
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                  shape: BoxShape.circle),
              // margin: PaddingManager.p15.copyWith(top: 0),
              padding: PaddingManager.p15.copyWith(top: 10),
              child: SizedBox(
                width: 140,
                height: 140,
                child: ClipOval(
                  child: _image == null
                      ? AuthBloc.user.photoUrl == null
                          ? const ErrorImage(
                              "https://www.shareicon.net/download/2016/06/27/787159_people_512x512.png",
                              fit: BoxFit.fill)
                          : Base64Image(AuthBloc.user.photoUrl!,
                              fit: BoxFit.fill)
                      : Image.memory(_image!.readAsBytesSync()),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorManager.yellow,
              child: IconButton(
                  iconSize: 25,
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _image = File(pickedFile.path);
                      });
                    } else {
                      showToast("No image selected");
                    }
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
            )
          ],
        );
      });
  Widget sendButton(BuildContext context) =>
      BlocBuilder<UserInfoBloc, InfoStates>(
        builder: (context, state) {
          return AnimatedCrossFade(
              firstChild: state.status == InfoStatus.done
                  ? Text(
                      "تم تعديل البيانات بنجاح",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_image != null ||
                              AuthBloc.user.photoUrl != null) {
                            context.read<UserInfoBloc>().add(RegisterDataEvent(
                                AppUser(
                                  id: AuthBloc.user.id,
                                  youtubeLink: AuthBloc.user.youtubeLink,
                                  photoUrl: convertImageToBase64(_image) ??
                                      AuthBloc.user.photoUrl,
                                  email: AuthBloc.user.email,
                                  verified: AuthBloc.user.verified,
                                  nationalId: controllers['id']!.text,
                                  phoneNumber: controllers['phone']!.text,
                                  name: controllers['name']!.text,
                                  birthDate: controllers['date']!.text,
                                  height:
                                      double.parse(controllers['height']!.text),
                                  weight: double.tryParse(
                                      controllers['weight']!.text),
                                  parentData: ParentData(
                                      name: controllers['parentName']!.text,
                                      id: controllers['parentPhone']!.text,
                                      job: controllers['parentJob']!.text,
                                      phone: controllers['parentPhone']!.text,
                                      address: controllers['parentJob']!.text),
                                  city: controllers['city']!.text,
                                  playedBefore: playedBefore,
                                  playType: playType,
                                  experience: controllers['experience']!.text,
                                ),
                                AuthBloc.user.photoUrl != null));
                          } else {
                            showToast("لا تنسي رفع الصوره");
                          }
                        }
                      },
                      child: const Text("تعديل")),
              secondChild: const LoadingText(),
              crossFadeState: state.status == InfoStatus.loading
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 50));
        },
      );
}
