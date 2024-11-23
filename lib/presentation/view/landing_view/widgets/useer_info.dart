import 'package:final_projects/presentation/resources/theme/theme_manager.dart';
import 'package:flutter/material.dart';


import '../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../resources/string_manager.dart';
import '../../../shared/widget/avatar.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Hero(
              tag: "image",
              child: Avatar(
                AuthBloc.user.photoUrl ?? "https://www.shareicon.net/download/2016/06/27/787159_people_512x512.png",
                width: 100,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: FilledButton.tonalIcon(
              style: FilledButton.styleFrom(
                backgroundColor: ColorManager.darkBlue,
                fixedSize: const Size(100, 20)
              ),
                icon: const Icon(Icons.verified,size: 20,color: Colors.yellow,),
                onPressed: () {},
                label: const Text("مشترك" , style: TextStyle(fontSize: 16,color: Colors.yellow,),)),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Text(
           "Abdelmenam Tarek",
            // AuthBloc.user.name ?? StringManger.appUser,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w100,
                  height: 1,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,
                ),
          ),
        )
      ],
    );
  }
}
