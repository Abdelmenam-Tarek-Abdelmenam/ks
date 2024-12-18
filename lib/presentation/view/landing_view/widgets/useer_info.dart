import 'package:final_projects/presentation/resources/theme/theme_manager.dart';
import 'package:final_projects/presentation/shared/widget/error_image.dart';
import 'package:flutter/material.dart';


import '../../../../bloc/auth_bloc/auth_status_bloc.dart';

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
              child: AuthBloc.user.photoUrl == null
                  ? const ErrorImage(
                  "https://www.shareicon.net/download/2016/06/27/787159_people_512x512.png",
                  fit: BoxFit.fill)
                  : Base64Image(
                AuthBloc.user.photoUrl !,
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
                icon:  Icon(AuthBloc.user.verified ? Icons.verified : Icons.not_interested,size: 20,color: AuthBloc.user.verified ? Colors.yellow : Colors.redAccent,),
                onPressed: () {},
                label:  Text(  "مشترك" , style: TextStyle(fontSize: 16,color: AuthBloc.user.verified ? Colors.yellow : Colors.redAccent,),)),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Text(
            AuthBloc.user.name,
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
